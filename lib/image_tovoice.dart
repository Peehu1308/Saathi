import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translator/translator.dart';

class Image_to_Voice extends StatefulWidget {
  const Image_to_Voice({super.key});

  @override
  State<Image_to_Voice> createState() => _Image_to_VoiceState();
}

class _Image_to_VoiceState extends State<Image_to_Voice> {
  File? image;
  String extractedText = '';
  String translatedText = '';
  bool showTranslation = false;

  final FlutterTts flutterTts = FlutterTts();
  final ImagePicker picker = ImagePicker();
  final translator = GoogleTranslator();

  Future<void> pickImage() async {
    final XFile? imagepicked = await picker.pickImage(source: ImageSource.gallery);
    if (imagepicked != null) {
      setState(() {
        image = File(imagepicked.path);
        extractedText = '';
        translatedText = '';
        showTranslation = false;
      });
      await ExtractedText(File(imagepicked.path));
    }
  }

  Future<void> ExtractedText(File imageFile) async {
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
      var translation = await translator.translate(text, to: 'hi'); // 'hi' for Hindi
      setState(() {
        translatedText = translation.text;
        showTranslation = true;
      });
      await speak(translatedText);
    }
  }

  Future<void> speak(String text) async {
    if (text.isNotEmpty) {
      await flutterTts.setLanguage("en-UK");
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
        title: Text("Saathi", style: TextStyle(color: Colors.black)),
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.black)),
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: image != null
                          ? Image.file(image!, fit: BoxFit.contain)
                          : Text("No image selected", style: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(onPressed: pickImage, icon: Icon(Icons.camera_alt_outlined)),
                        IconButton(onPressed: () {}, icon: Icon(Icons.mic)),
                        IconButton(
                          onPressed: () => translateText(extractedText),
                          icon: Icon(Icons.translate_rounded),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.black)),
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      extractedText.isNotEmpty ? extractedText : "No Text Detected",
                      style: TextStyle(fontSize: 15),
                    ),
                    if (showTranslation && translatedText.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "Translated: $translatedText",
                          style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
