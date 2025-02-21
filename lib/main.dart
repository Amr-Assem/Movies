import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'onboarding_screen.dart';
import 'splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData.dark(),
      home: MainScreen(),
      initialRoute: SplashScreen.routeName,
      routes: {
        MainScreen.routeName: (context) => MainScreen(),
        OnboardingScreen.routeName: (context) => OnboardingScreen(),
        SplashScreen.routeName: (context) => SplashScreen(),
      },
    );
  }
}
