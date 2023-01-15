import 'package:flutter/material.dart';
import 'package:flutter_internship_assignment/homepage.dart';
import 'package:flutter_internship_assignment/onBoardingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isFirstTimeUser = true;

  @override
  void initState() {
    redirect();
    super.initState();
  }

  Future<void> redirect() async {
    await Future.delayed(const Duration(seconds: 1));
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      isFirstTimeUser = (prefs.getBool('firstTime') ?? true);
    });
    if (isFirstTimeUser == true) {
      Navigator.of(context).pushReplacementNamed('/onboard');
      prefs.setBool('firstTime', false);
    } else {
      Navigator.of(context).pushReplacementNamed('/homepage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
