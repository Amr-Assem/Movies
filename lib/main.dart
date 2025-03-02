import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';
import 'onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;

  runApp(MyApp(showHome: showHome));
}

class MyApp extends StatelessWidget {
  final bool showHome;

  const MyApp({
    Key? key,
    required this.showHome,
  }) : super(key: key);

=======

import 'home_screen.dart';
import 'onboarding_screen.dart';
import 'splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
>>>>>>> feature-branch
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData.dark(),
<<<<<<< HEAD
      home: showHome ? MainScreen() : OnboardingScreen(),
      routes: {
        MainScreen.routeName: (context) => MainScreen(),
        OnboardingScreen.routeName: (context) => OnboardingScreen(),
=======
      home: MainScreen(),
      initialRoute: SplashScreen.routeName,
      routes: {
        MainScreen.routeName: (context) => MainScreen(),
        OnboardingScreen.routeName: (context) => OnboardingScreen(),
        SplashScreen.routeName: (context) => SplashScreen(),
>>>>>>> feature-branch
      },
    );
  }
}
