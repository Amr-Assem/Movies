import 'package:flutter/material.dart';
import 'package:movies_app/core/app_assets.dart';

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
      alignment: Alignment.bottomCenter,
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
        // Content
        Positioned(
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: AppAssets.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppAssets.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                description.isEmpty
                    ? const SizedBox(height: 0)
                    : SizedBox(height: 8),

                // Description
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppAssets.white,
                    fontSize: 20,
                  ),
                ),

                description.isEmpty
                    ? const SizedBox(height: 0)
                    : SizedBox(height: 16),

                // Buttons
                Container(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      if (onFinish != null) {
                        onFinish!();
                      } else {
                        onNext();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppAssets.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      maxLines: 1,
                      onFinish != null ? 'Finish' : 'Next',
                      style: TextStyle(
                        color: AppAssets.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 16),

                if (onBack != null)
                  Container(
                    width: double.infinity,
                    height: 55,
                    child: OutlinedButton(
                      onPressed: () => onBack!(),
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          side: BorderSide(color: AppAssets.primary, width: 2)),
                      child: Text(
                        'Back',
                        style: TextStyle(
                          color: AppAssets.primary,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
