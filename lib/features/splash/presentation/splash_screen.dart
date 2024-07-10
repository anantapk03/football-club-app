// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _controller = SplashController();

  @override
  void initState() {
    _controller.onInit();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.onInit();
    return Scaffold(
      backgroundColor: Color(0xff593265),
      body: Center(
        child: Image.asset(
          'assets/images/logo_app2.png',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
