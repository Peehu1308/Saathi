import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      backgroundColor: Colors.teal[600],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
    );

    final labelStyle = const TextStyle(fontSize: 22, fontWeight: FontWeight.w600);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Saathi",
          style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.teal[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "What would you like to do?",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            _buildActionButton(context, Icons.image, "Scan Image", '/imageToVoice', buttonStyle, labelStyle),
            const SizedBox(height: 24),
            _buildActionButton(context, Icons.mic, "Voice Input", '/voice', buttonStyle, labelStyle),
            const SizedBox(height: 24),
            _buildActionButton(context, Icons.star, "Favorites", '/favorites', buttonStyle, labelStyle),
            const SizedBox(height: 24),
            _buildActionButton(context, Icons.settings, "Settings", '/settings', buttonStyle, labelStyle),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, IconData icon, String label, String route,
      ButtonStyle style, TextStyle labelStyle) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => Navigator.pushNamed(context, route),
        icon: Icon(icon, size: 30,color: Colors.white,),
        label: Text(label, style:TextStyle(fontSize: 22, fontWeight: FontWeight.w600,color: Colors.white)),
        
        style:style
      ),
    );
  }
}
