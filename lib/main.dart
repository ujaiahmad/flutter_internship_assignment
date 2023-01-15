import 'package:flutter/material.dart';
import 'package:flutter_internship_assignment/homepage.dart';
import 'package:flutter_internship_assignment/onBoardingScreen.dart';
import 'package:flutter_internship_assignment/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'root',
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: SplashScreen(),
      initialRoute: '/',
      routes: {
        '/': (_) =>
            const SplashScreen(), //will show onboarding screen if first time user
        '/homepage': (_) => const MyHomePage(), //show attendance record
        '/onboard': (_) => const OnboardingScreen(), //show onboarding sc
      },
    );
  }
}
