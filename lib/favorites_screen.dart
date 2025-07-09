import 'dart:io';
import 'package:flutter/material.dart';
import 'package:saathi/favorite_items.dart';


class FavoritesScreen extends StatelessWidget {
  final List<FavoriteItem> favorites;

  const FavoritesScreen({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites", style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.teal[700],
      ),
      body: favorites.isEmpty
          ? Center(
              child: Text("No favorites yet.", style: TextStyle(fontSize: 18)),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final item = favorites[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  elevation: 4,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(12),
                    leading: Image.file(
                      File(item.imagePath),
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      item.extractedText,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16),
                    ),
                    subtitle: item.translatedText != null
                        ? Text("Translated: ${item.translatedText}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontStyle: FontStyle.italic, fontSize: 14))
                        : null,
                    trailing: IconButton(
                      icon: Icon(Icons.volume_up),
                      onPressed: () {
                        // Optional: Call a speak() function to read aloud
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
