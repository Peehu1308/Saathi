class FavoriteItem {
  final String imagePath;
  final String extractedText;
  final String? translatedText;

  FavoriteItem({
    required this.imagePath,
    required this.extractedText,
    this.translatedText,
  });
}
