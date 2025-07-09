import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _fadeIn = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();

    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/home');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[600],
      body: Center(
        child: FadeTransition(
          opacity: _fadeIn,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.favorite, color: Colors.white, size: 80), // Replace with your logo
              SizedBox(height: 20),
              Text(
                "Welcome to",
                style: TextStyle(color: Colors.white70, fontSize: 24),
              ),
              SizedBox(height: 8),
              Text(
                "Saathi",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 16),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
                strokeWidth: 2.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
