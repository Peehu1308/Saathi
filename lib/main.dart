import 'package:flutter/material.dart';
import 'package:saathi/favorite_items.dart';
import 'package:saathi/favorites_screen.dart';
import 'package:saathi/home.dart';
import 'package:saathi/image_tovoice.dart';
import 'package:saathi/setting.dart';
import 'package:saathi/splash.dart';
import 'package:saathi/voiceinput.dart';


// Dummy list of favorites — in a real app, you'd load this from local storage
final favoriteList = <FavoriteItem>[]; // You must define this model in favorites_screen.dart

void main() {
  runApp(SaathiApp());
}

class SaathiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saathi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomeScreen(),
        '/imageToVoice': (context) => ImageToVoice(),
        '/voice': (context) => VoiceInputScreen(),
        '/favorites': (context) => FavoritesScreen(favorites: favoriteList),
        '/settings': (context) => SettingsScreen(), 
      },
    );
  }
}
