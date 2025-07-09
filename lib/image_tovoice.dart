import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translator/translator.dart';

class ImageToVoice extends StatefulWidget {
  const ImageToVoice({super.key});

  @override
  State<ImageToVoice> createState() => _ImageToVoiceState();
}

class _ImageToVoiceState extends State<ImageToVoice> {
  File? image;
  String extractedText = '';
  String translatedText = '';
  bool showTranslation = false;

  final FlutterTts flutterTts = FlutterTts();
  final ImagePicker picker = ImagePicker();
  final translator = GoogleTranslator();

  Future<void> pickImage() async {
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
        extractedText = '';
        translatedText = '';
        showTranslation = false;
      });
      await extractText(File(pickedImage.path));
    }
  }

  Future<void> extractText(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    setState(() {
      extractedText = recognizedText.text;
    });
    await speak(extractedText);
    textRecognizer.close();
  }

  Future<void> translateText(String text) async {
    if (text.isNotEmpty) {
      var translation = await translator.translate(text, to: 'hi'); // to Hindi
      setState(() {
        translatedText = translation.text;
        showTranslation = true;
      });
      await speak(translatedText, languageCode: 'hi-IN');
    }
  }

  Future<void> speak(String text, {String languageCode = 'en-UK'}) async {
    if (text.isNotEmpty) {
      await flutterTts.setLanguage(languageCode);
      await flutterTts.setPitch(1.0);
      await flutterTts.speak(text);
    }
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Saathi", style: TextStyle(color: Colors.white, fontSize: 24)),
        backgroundColor: Colors.teal[700],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: pickImage,
              icon: Icon(Icons.image, size: 28,color: Colors.white,),
              label: Text("Pick Image", style: TextStyle(fontSize: 20,color: Colors.white)),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.teal[600],
              ),
            ),
            SizedBox(height: 20),
            if (image != null)
              Container(
                height: 250,
                decoration: BoxDecoration(border: Border.all(color: Colors.teal)),
                child: Image.file(image!, fit: BoxFit.contain),
              )
            else
              Center(child: Text("No image selected", style: TextStyle(fontSize: 18, color: Colors.grey))),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => speak(extractedText),
              icon: Icon(Icons.volume_up, size: 28,color: Colors.teal),
              label: Text("Read Extracted Text", style: TextStyle(fontSize: 20,color: Colors.teal)),
              style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 16)),
            ),
            SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () => translateText(extractedText),
              icon: Icon(Icons.translate, size: 28,color: Colors.teal),
              label: Text("Translate and Read", style: TextStyle(fontSize: 20,color: Colors.teal)),
              style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 16)),
            ),
            SizedBox(height: 24),
            Text("Extracted Text:", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(
              extractedText.isNotEmpty ? extractedText : "No text detected.",
              style: TextStyle(fontSize: 18),
            ),
            if (showTranslation && translatedText.isNotEmpty) ...[
              SizedBox(height: 20),
              Text("Translated Text:", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text(translatedText, style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
            ],
          ],
        ),
      ),
    );
  }
}
