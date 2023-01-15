import 'package:flutter/material.dart';
import 'package:flutter_internship_assignment/onBoardingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isFirstTimeUser = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    redirect();
  }

  Future<void> redirect() async {
    await Future.delayed(const Duration(seconds: 1));
    final prefs = await SharedPreferences.getInstance();
    bool redicrectCalled = false;
    setState(() {
      isFirstTimeUser = (prefs.getBool('firstTime') ?? true);
    });

    if (redicrectCalled || !mounted) {
      return;
    }

    redicrectCalled = true;

    if (isFirstTimeUser) {
      prefs.setBool('firstTime', false);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const OnboardingScreen()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MyHomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
