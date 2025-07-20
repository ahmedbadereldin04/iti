import 'package:flutter/material.dart';
import 'account_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
    AnimationController(duration: Duration(seconds: 2), vsync: this)
      ..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.7, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void navigateToAccountPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AccountPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          FadeTransition(
            opacity: _animation,
            child: Text(
              'Welcome to My App',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 30),
          ElevatedButton(
              onPressed: navigateToAccountPage,
              child: Text('Create an Account')),
        ]),
      ),
    );
  }
}