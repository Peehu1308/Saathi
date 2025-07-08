import 'package:flutter/material.dart';
import 'package:saathi/image.dart';
import 'package:saathi/image_tovoice.dart';

void main() {
  runApp(MaterialApp(
    title: 'Saathi',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      textTheme: TextTheme(
        headlineSmall: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(fontSize: 20),
        bodyMedium: TextStyle(fontSize: 18),
      ),
    ),
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5FFFA), // Soft background
      appBar: AppBar(
        title: Text("👵🏻 Saathi 👴🏻", style: TextStyle(fontSize: 26)),
        centerTitle: true,
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
        elevation: 5,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.image_search, size: 100, color: Colors.teal.shade700),
              SizedBox(height: 30),
              Text(
                'Welcome to Saathi',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.teal.shade800,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Tap the button below to read text from an image out loud.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              ElevatedButton.icon(
                icon: Icon(Icons.volume_up_rounded, size: 28),
                label: Text(
                  "Open Image Reader",
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade600,
                  foregroundColor: Colors.white,
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 5,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ImageToVoice()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
