import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';

import 'homepage.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: OnBoardingSlider(
        headerBackgroundColor: Colors.white,
        finishButtonText: 'Get Started',
        skipTextButton: const Text('Skip'),
        controllerColor: Colors.blue,
        pageBackgroundColor: Colors.white,
        // trailingFunction: toHomePage(),
        onFinish: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const MyHomePage(),
          ));
        },
        // indicatorAbove: false,
        //trailing: Text('Login'),
        background: [
          Image.asset(
            'asset/overview.png',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.25,
          ),
          Image.asset(
            'asset/changeformat.png',
            width: MediaQuery.of(context).size.width,
          ),
          Image.asset(
            'asset/addattendance.png',
            width: MediaQuery.of(context).size.width,
          ),
          Image.asset(
            'asset/search.png',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.25,
          ),
          Image.asset(
            'asset/share.png',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.25,
          ),
        ],
        totalPage: 5,
        speed: 2,
        pageBodies: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const <Widget>[
              Text(
                'The homepage will show the attendance list.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20)
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Text('Toggle the date format as you desire'),
              SizedBox(height: 15)
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Text('Add new attendance record'),
              SizedBox(height: 15)
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Text('Search for any record'),
              SizedBox(height: 15)
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Text('Share record to other application'),
              SizedBox(height: 70)
            ],
          ),
        ],
      ),
    );
  }
}
