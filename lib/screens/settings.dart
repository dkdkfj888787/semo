import 'dart:io';


import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../gen_l10n/app_localizations.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:index/models/server.dart';
import 'package:index/screens/company_info.dart';
import 'package:index/screens/open_source_libraries.dart';
import 'package:index/screens/subtitles_preferences.dart';

import 'package:index/utils/extractor.dart';
import 'package:index/utils/language_manager.dart';
import 'package:index/utils/preferences.dart';
import 'package:index/utils/spinner.dart';
import 'package:index/utils/urls.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  
  const Settings({Key? key, required this.onLanguageChange}) : super(key: key);
  
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Preferences _preferences = Preferences();
  Spinner? _spinner;
  String _currentLanguage = 'en';

  navigate({required Widget destination, bool replace = false}) async {
    SwipeablePageRoute pageTransition = SwipeablePageRoute(
      canOnlySwipeFromEdge: true,
      builder: (BuildContext context) => destination,
    );

    if (replace) {
      await Navigator.pushReplacement(
        context,
        pageTransition,
      );
    } else {
      await Navigator.push(
        context,
        pageTransition,
      );
    }
  }

  openServerSelector() async {
    String savedServerName = await _preferences.getServer();
    List<Server> servers = Extractor.servers;

    await showModalBottomSheet(
      context: context,
      builder: (context) {
        String serverName = savedServerName;

        return StatefulBuilder(
          builder: (context, setState) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: servers.length,
              itemBuilder: (context, index) {
                Server server = servers[index];
                bool isSelected = server.name == serverName;

                return ListTile(
                  selected: isSelected,
                  selectedColor: Theme.of(context).primaryColor,
                  selectedTileColor: Theme.of(context).primaryColor.withOpacity(.2),
                  titleTextStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  title: Text(server.name),
                  leading: isSelected ? Icon(Icons.check) : null,
                  onTap: () async {
                    await _preferences.setServer(server);
                    setState(() => serverName = server.name);
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  openSeekDurationSelector() async {
    int savedSeekDuration = await _preferences.getSeekDuration();
    List<int> seekDurations = [5, 15, 30, 45, 60];

    await showModalBottomSheet(
      context: context,
      builder: (context) {
        int seekDuration = savedSeekDuration;

        return StatefulBuilder(
          builder: (context, setState) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: seekDurations.length,
              itemBuilder: (context, index) {
                bool isSelected = seekDurations[index] == seekDuration;

                return ListTile(
                  selected: isSelected,
                  selectedColor: Theme.of(context).primaryColor,
                  selectedTileColor: Theme.of(context).primaryColor.withOpacity(.2),
                  titleTextStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  title: Text(seekDurations[index] != 60 ? '${seekDurations[index]} s' : '1 m'),
                  leading: isSelected ? Icon(Icons.check) : null,
                  onTap: () async {
                    await _preferences.setSeekDuration(seekDurations[index]);
                    setState(() => seekDuration = seekDurations[index]);
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  openAbout() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;

    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.all(18),
          child: SafeArea(
            top: false,
            left: false,
            right: false,
            bottom: Platform.isIOS,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/icon.png',
                  width: 200,
                  height: 200,
                ),
                Container(
                  margin: EdgeInsets.only(top: 25),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.displayMedium,
                      children: [
                        TextSpan(text: 'Developed by '),
                        TextSpan(
                          text: 'Moses Mbaga',
                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () async {
                            await launchUrl(Uri.parse(Urls.mosesGithub));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          '$version',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      Text(
                        ' · ',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      GestureDetector(
                        onTap: () async {
                          await launchUrl(Uri.parse(Urls.github));
                        },
                        child: Text(
                          'GitHub',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> clearRecentSearches({bool showSpinner = true, bool showSnackBar = true}) async {
    if (showSpinner) _spinner!.show();
    // Clear from local storage since we're in guest mode
    await _preferences.clearRecentSearches();
    if (showSpinner) _spinner!.dismiss();

    if (showSnackBar) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Recent searches cleared successfully',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          backgroundColor: Theme.of(context).cardColor,
        ),
      );
    }
  }

  Future<void> clearFavorites({bool showSpinner = true, bool showSnackBar = true}) async {
    if (showSpinner) _spinner!.show();
    // Clear from local storage since we're in guest mode
    await _preferences.clearFavorites();
    if (showSpinner) _spinner!.dismiss();

    if (showSnackBar) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Favorites cleared successfully',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          backgroundColor: Theme.of(context).cardColor,
        ),
      );
    }
  }

  Future<void> clearRecentlyWatched({bool showSpinner = true, bool showSnackBar = true}) async {
    if (showSpinner) _spinner!.show();
    // Clear from local storage since we're in guest mode
    await _preferences.clearRecentlyWatched();
    if (showSpinner) _spinner!.dismiss();

    if (showSnackBar) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Recently watched cleared successfully',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          backgroundColor: Theme.of(context).cardColor,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _loadCurrentLanguage();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _spinner = Spinner(context);

      await FirebaseAnalytics.instance.logScreenView(
        screenName: 'Settings',
      );
    });
  }

  _loadCurrentLanguage() async {
    final savedLocale = await LanguageManager.getSavedLanguage();
    setState(() {
      _currentLanguage = savedLocale.languageCode;
    });
  }

  openLanguageSelector() async {
    final l10n = AppLocalizations.of(context)!;
    
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        String selectedLanguage = _currentLanguage;

        return StatefulBuilder(
          builder: (context, setState) {
            return ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  selected: selectedLanguage == 'en',
                  selectedColor: Theme.of(context).primaryColor,
                  selectedTileColor: Theme.of(context).primaryColor.withOpacity(.2),
                  titleTextStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontWeight: selectedLanguage == 'en' ? FontWeight.bold : FontWeight.normal,
                  ),
                  title: Text(l10n.english),
                  leading: selectedLanguage == 'en' ? Icon(Icons.check) : null,
                  onTap: () async {
                    setState(() => selectedLanguage = 'en');
                    widget.onLanguageChange(Locale('en'));
                    this.setState(() => _currentLanguage = 'en');
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  selected: selectedLanguage == 'ar',
                  selectedColor: Theme.of(context).primaryColor,
                  selectedTileColor: Theme.of(context).primaryColor.withOpacity(.2),
                  titleTextStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontWeight: selectedLanguage == 'ar' ? FontWeight.bold : FontWeight.normal,
                  ),
                  title: Text(l10n.arabic),
                  leading: selectedLanguage == 'ar' ? Icon(Icons.check) : null,
                  onTap: () async {
                    setState(() => selectedLanguage = 'ar');
                    widget.onLanguageChange(Locale('ar'));
                    this.setState(() => _currentLanguage = 'ar');
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget GuestCard() {
    final l10n = AppLocalizations.of(context)!;
    
    return Container(
      margin: EdgeInsets.only(
        top: 18,
        left: 18,
        right: 18,
      ),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .2,
            height: MediaQuery.of(context).size.width * .2,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).cardColor,
              child: Icon(
                Icons.person,
                color: Theme.of(context).primaryColor,
                size: 40,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Guest User',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 2.5)),
                  Text(
                    'Using guest mode',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white54),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Text SectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
        fontSize: 20,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  SettingsTile SectionTile({
    required String title,
    String? description,
    required IconData icon,
    Widget? trailing,
    required Function(BuildContext context) onPressed,
  }) {
    return SettingsTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.displayMedium,
      ),
      description: description != null ? Text(
        description,
        style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Colors.white54),
      ) : null,
      leading: Icon(icon),
      trailing: trailing,
      backgroundColor: Platform.isIOS ? Theme.of(context).cardColor: Colors.transparent,
      onPressed: onPressed,
    );
  }

  SettingsList Settings() {
    final l10n = AppLocalizations.of(context)!;
    
    SettingsThemeData settingsThemeData = SettingsThemeData(
      titleTextColor: Theme.of(context).primaryColor,
      settingsListBackground: Theme.of(context).scaffoldBackgroundColor,
    );

    return SettingsList(
      lightTheme: settingsThemeData,
      darkTheme: settingsThemeData,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      sections: [
        SettingsSection(
          title: SectionTitle(l10n.language),
          tiles: [
            SectionTile(
              title: l10n.language,
              description: _currentLanguage == 'en' ? l10n.english : l10n.arabic,
              icon: Icons.language,
              trailing: Platform.isIOS ? Icon(Icons.keyboard_arrow_right_outlined) : null,
              onPressed: (context) => openLanguageSelector(),
            ),
          ],
        ),
        SettingsSection(
          title: SectionTitle('Playback'),
          tiles: [
            SectionTile(
              title: 'Server',
              description: 'Select a server that works best for you',
              icon: Icons.dns_outlined,
              trailing: Platform.isIOS ? Icon(Icons.keyboard_arrow_right_outlined) : null,
              onPressed: (context) => openServerSelector(),
            ),
            SectionTile(
              title: 'Subtitles',
              description: 'Customize the subtitles style to fit your preference',
              icon: Icons.subtitles_outlined,
              trailing: Platform.isIOS ? Icon(Icons.keyboard_arrow_right_outlined) : null,
              onPressed: (context) => navigate(destination: SubtitlesPreferences()),
            ),
            SectionTile(
              title: 'Seek duration',
              description: 'Adjust how long the seek forward/backward duration is',
              icon: Icons.update,
              trailing: Platform.isIOS ? Icon(Icons.keyboard_arrow_right_outlined) : null,
              onPressed: (context) => openSeekDurationSelector(),
            ),
          ],
        ),
        SettingsSection(
          title: SectionTitle('App'),
          tiles: [
            SectionTile(
              title: l10n.aboutCompany,
              icon: Icons.business,
              trailing: Platform.isIOS ? Icon(Icons.keyboard_arrow_right_outlined) : null,
              onPressed: (context) => navigate(destination: CompanyInfo()),
            ),
            SectionTile(
              title: 'About',
              icon: Icons.info_outline_rounded,
              trailing: Platform.isIOS ? Icon(Icons.keyboard_arrow_right_outlined) : null,
              onPressed: (context) => openAbout(),
            ),
            SectionTile(
              title: 'Open Source libraries',
              icon: Icons.description_outlined,
              trailing: Platform.isIOS ? Icon(Icons.keyboard_arrow_right_outlined) : null,
              onPressed: (context) => navigate(destination: OpenSourceLibraries()),
            ),
          ],
        ),
        SettingsSection(
          title: SectionTitle('Other'),
          tiles: [
            SectionTile(
              title: 'Clear recent searches',
              description: 'Deletes all the recent search queries',
              icon: Icons.search_off,
              trailing: Platform.isIOS ? Icon(Icons.keyboard_arrow_right_outlined) : null,
              onPressed: (context) => clearRecentSearches(),
            ),
            SectionTile(
              title: 'Clear favorites',
              description: 'Deletes all your favorites',
              icon: Icons.favorite_border,
              trailing: Platform.isIOS ? Icon(Icons.keyboard_arrow_right_outlined) : null,
              onPressed: (context) => clearFavorites(),
            ),
            SectionTile(
              title: 'Clear recently watched',
              description: 'Deletes all the progress of recently watched movies and TV shows',
              icon: Icons.video_library_outlined,
              trailing: Platform.isIOS ? Icon(Icons.keyboard_arrow_right_outlined) : null,
              onPressed: (context) => clearRecentlyWatched(),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GuestCard(),
            Settings(),
          ],
        ),
      ),
    );
  }
}