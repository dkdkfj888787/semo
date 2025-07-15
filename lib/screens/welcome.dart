import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../gen_l10n/app_localizations.dart';
import 'landing.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class WelcomeScreen extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  
  const WelcomeScreen({Key? key, required this.onLanguageChange}) : super(key: key);
  
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _slideController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));
    
    // Start animations
    _fadeController.forward();
    Future.delayed(Duration(milliseconds: 300), () {
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      SwipeablePageRoute(
        canOnlySwipeFromEdge: true,
        builder: (context) => Landing(onLanguageChange: widget.onLanguageChange),
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).dialogBackgroundColor,
          title: Text(
            AppLocalizations.of(context)?.language ?? 'Language',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Text('🇺🇸', style: TextStyle(fontSize: 24)),
                title: Text(
                  AppLocalizations.of(context)?.english ?? 'English',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                onTap: () {
                  widget.onLanguageChange(Locale('en'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Text('🇸🇦', style: TextStyle(fontSize: 24)),
                title: Text(
                  AppLocalizations.of(context)?.arabic ?? 'العربية',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                onTap: () {
                  widget.onLanguageChange(Locale('ar'));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isRTL = Directionality.of(context) == TextDirection.rtl;
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Language selector
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: _showLanguageDialog,
                    icon: Icon(
                      Icons.language,
                      color: Colors.white70,
                      size: 28,
                    ),
                  ),
                ],
              ),
              
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo with fade animation
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).primaryColor.withOpacity(0.3),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(
                            'assets/icon.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 40),
                    
                    // Welcome text with slide animation
                    SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Column(
                          children: [
                            Text(
                              l10n?.welcome ?? 'Welcome to Index',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Colors.white,
                                fontSize: 32,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            
                            SizedBox(height: 20),
                            
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                l10n?.welcomeDescription ?? 
                                'Discover a vast library of entertainment, from blockbuster hits to indie gems, all tailored to your tastes.',
                                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                  color: Colors.white70,
                                  height: 1.6,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Guest login button with slide animation
              SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _navigateToHome,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                            elevation: 8,
                            shadowColor: Theme.of(context).primaryColor.withOpacity(0.4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person_outline,
                                size: 24,
                              ),
                              SizedBox(width: 12),
                              Text(
                                l10n?.continueAsGuest ?? 'Continue as Guest',
                                style: GoogleFonts.lexend(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 20),
                      
                      // Company info
                      Text(
                        'Powered by ${l10n?.companyName ?? 'VOXIN'}',
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: Colors.white38,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}