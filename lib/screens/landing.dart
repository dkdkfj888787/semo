import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import '../gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:index/screens/fragments.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:video_player/video_player.dart';

class Landing extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  
  const Landing({Key? key, required this.onLanguageChange}) : super(key: key);
  
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  VideoPlayerController? _controller;

  initializeVideo() {
    _controller = VideoPlayerController.asset('assets/cover_portrait.mp4');
    _controller!.initialize().then((_) {
      _controller!.play();
      _controller!.setLooping(true);
    });
  }

  continueAsGuest() async {
    navigate(destination: Fragments(onLanguageChange: widget.onLanguageChange));
  }

  navigate({required Widget destination}) async {
    SwipeablePageRoute pageTransition = SwipeablePageRoute(
      canOnlySwipeFromEdge: true,
      builder: (BuildContext context) => destination,
    );

    await Navigator.pushReplacement(
      context,
      pageTransition,
    );
  }

  @override
  void initState() {
    super.initState();

    initializeVideo();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await FirebaseAnalytics.instance.logScreenView(
        screenName: 'Landing',
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_controller != null) {
      _controller!.pause();
      _controller!.dispose();
      _controller = null;
    }
  }

  Widget BackgroundTint() {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.5),
    );
  }

  Widget ContinueAsGuestButton() {
    final l10n = AppLocalizations.of(context)!;
    
    return Container(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        child: Container(
          width: double.infinity,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.userLarge,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 16,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Spacer(),
                      Text(
                        l10n.continueAsGuest,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      Spacer(),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          side: BorderSide(
            width: 3,
            color: Colors.white,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: () {
          continueAsGuest();
        },
      ),
    );
  }

  Widget Content() {
    final l10n = AppLocalizations.of(context)!;
    
    return Column(
      children: [
        Spacer(),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 24,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 36),
                child: Container(
                  width: double.infinity,
                  child: Text(
                    l10n.welcome,
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  width: double.infinity,
                  child: Text(
                    l10n.welcomeDescription,
                    style: Theme.of(context).textTheme.displayMedium,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              SafeArea(
                top: false,
                left: false,
                right: false,
                bottom: true,
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: 18,
                  ),
                  child: ContinueAsGuestButton(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _controller != null ? Stack(
        children: [
          VideoPlayer(_controller!),
          BackgroundTint(),
          Content(),
        ],
      ) : Container(),
    );
  }
}