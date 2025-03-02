import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:movies_app/core/app_assets.dart';
import 'package:movies_app/home_screen.dart';
import 'package:movies_app/widgets/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
=======
>>>>>>> feature-branch

class OnboardingScreen extends StatefulWidget {
  static const String routeName = "OnBoarding";

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              OnboardingPage(
<<<<<<< HEAD
                image: AppAssets.onboarding1,
=======
                image: 'assets/images/OnBoarding1.png',
>>>>>>> feature-branch
                title: 'Find Your Next Favorite Movie Here',
                description:
                    'Get access to a huge library of movies to suit all tastes. You will surely like it.',
                onNext: () => _pageController.nextPage(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeIn,
                ),
              ),
              OnboardingPage(
<<<<<<< HEAD
                image: AppAssets.onboarding2,
=======
                image: 'assets/images/OnBoarding2.png',
>>>>>>> feature-branch
                title: 'Discover Movies',
                description:
                    'Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.',
                onNext: () => _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                ),
                onBack: () => _pageController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                ),
              ),
              OnboardingPage(
<<<<<<< HEAD
                image: AppAssets.onboarding3,
=======
                image: 'assets/images/OnBoarding3.png',
>>>>>>> feature-branch
                title: 'Explore All Genres',
                description:
                    'Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.',
                onNext: () => _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                ),
                onBack: () => _pageController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                ),
              ),
              OnboardingPage(
<<<<<<< HEAD
                image: AppAssets.onboarding4,
=======
                image: 'assets/images/OnBoarding4.png',
>>>>>>> feature-branch
                title: 'Create Watchlists',
                description:
                    'Save movies to your watchlist to keep track of what you want to watch next.',
                onNext: () => _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                ),
                onBack: () => _pageController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                ),
              ),
              OnboardingPage(
<<<<<<< HEAD
                image: AppAssets.onboarding5,
=======
                image: 'assets/images/OnBoarding5.png',
>>>>>>> feature-branch
                title: 'Rate, Review, and Learn',
                description:
                    "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.",
                onNext: () => _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                ),
                onBack: () => _pageController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                ),
              ),
              OnboardingPage(
<<<<<<< HEAD
                image: AppAssets.onboarding6,
                title: 'Start Watching Now',
=======
                image: 'assets/images/OnBoarding6.png',
                title: '    Rate, Review, and Learn   ',
>>>>>>> feature-branch
                description: '',
                onBack: () => _pageController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                ),
                onNext: () => _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                ),
                onFinish: () {
<<<<<<< HEAD
                  _onGetStarted();
=======
                  // Navigate to the home screen using pushNamed
                  Navigator.of(context).pushNamed('Home');
>>>>>>> feature-branch
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
<<<<<<< HEAD

  void _onGetStarted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('showHome', true);
    Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
=======
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final Function onNext;
  final Function? onBack;
  final Function? onFinish;

  OnboardingPage({
    required this.image,
    required this.title,
    required this.description,
    required this.onNext,
    this.onBack,
    this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Image background
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Gradient overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.7),
                Colors.transparent,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        // Content
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(

                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        description,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Buttons stacked vertically
              Center(
                child: Container(
                  color: Colors.black87,
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (onFinish != null) {
                            onFinish!();
                          } else {
                            onNext();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFDBF00),
                          padding:
                              EdgeInsets.symmetric(horizontal: 160, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          maxLines: 1,
                         // overflow: TextOverflow.ellipsis,
                          onFinish != null ? 'finish' : 'Next',
                          style: TextStyle(

                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 8), // Space between the buttons
                      if (onBack != null)
                        ElevatedButton(
                          onPressed: () => onBack!(),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 160, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              side:
                                  BorderSide(color: Color(0xFFFDBF00), width: 2)),
                          child: Text(
                            'Back',
                            style: TextStyle(
                                color: Color(0xFFFDBF00),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
>>>>>>> feature-branch
  }
}
