import 'package:flutter/material.dart';
import 'package:givenget/screens/auth/signup_screen.dart';
import 'package:givenget/widgets/custom_green_button.dart';
import 'dart:async';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../auth/login_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  bool showOnboarding = false;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      setState(() {
        showOnboarding = true; // Show onboarding after splash
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return showOnboarding ? const OnboardingScreen() : const SplashScreen();
  }
}

// Splash Screen Widget
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/GiveNGet.gif',
          width: 200,
          height: 200,         
        ),
      ),
    );
  }
}

// Onboarding Screen Widget
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;
  int currentPage = 0; // Track the current page

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevent resizing when keyboard pops up
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                currentPage = index; // Track current page
                isLastPage = index == 2; // Update last page flag
              });
            },
            children: [
              buildPage(
                'assets/images/intro-img-1.png',
                'Give Freely, Change Lives',
                'Donate items you no longer need to people who truly need them. No money required, just kindness!',
              ),
              buildPage(
                'assets/images/intro-img-2.png',
                'Extending Hearts, Transforming Lives',
                'Post the items you no longer need and connect with those who can benefit from them. Every item shared brings a positive impact to someone in need!',
              ),
              buildPage(
                'assets/images/intro-img-3.png',
                'Request & Receive with Ease',
                'See something you need? Simply show interest in a posted item, and if selected, arrange to receive it. Giving and receiving has never been this simple!',
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(26.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: const WormEffect(
                    dotHeight: 5,
                    dotWidth: 24,
                    activeDotColor: Color(0xFF3A6351),
                    dotColor: Color(0xFF999999),
                    spacing: 6,
                    paintStyle: PaintingStyle.fill,
                  ),
                ),
                const SizedBox(height: 20),
                isLastPage
                    ? Center(
                        child: CustomGreenButton(
                          text: 'Get Started', 
                          onPressed: () {
                          Navigator.pushReplacementNamed(context, '/signup');
                        })
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          currentPage > 0
                              ? TextButton(
                                  onPressed: () => _controller.previousPage(
                                    duration:
                                        const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  ),
                                  child: const Text(
                                    "Back",
                                    style: TextStyle(
                                        color: Color(0xFF3A6351),
                                        fontSize: 18),
                                  ),
                                )
                              : TextButton(
                                  onPressed: () => _controller.jumpToPage(2),
                                  child: const Text(
                                    "Skip",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 18),
                                  ),
                                ),
                          TextButton(
                            onPressed: () => _controller.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            ),
                            child: const Text(
                              "Next",
                              style: TextStyle(
                                  color: Color(0xFF3A6351), fontSize: 18),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }



  Widget buildPage(String imagePath, String mainText, String subText) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:  Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0,bottom: 10.0,top: 24.0),
        child: Column(
          children: [
            Image.asset(
            'assets/images/givenget-logo.png',
            width: 120,
            height: 120,         
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [   
                SizedBox(height: 40),          
                Text(
                  mainText,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                 SizedBox(height: 40),
                 Image.asset(imagePath, height: 200),
                 SizedBox(height: 80),
                 SizedBox(
                  width: 300,
                   child: Text(
                    subText,
                    style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 90, 89, 89)),
                    textAlign: TextAlign.center,
                    ),
                 ),
                ],
              ),
            )         
          ],
        ),
      ),
    );
  }
}
