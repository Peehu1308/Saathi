// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';

// void main() {
//   runApp(TextToVoiceApp());
// }

// class TextToVoiceApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Text to Voice',
//       theme: ThemeData(
//         primarySwatch: Colors.deepPurple,
//       ),
//       home: TextToSpeechScreen(),
//     );
//   }
// }

// class TextToSpeechScreen extends StatefulWidget {
//   @override
//   _TextToSpeechScreenState createState() => _TextToSpeechScreenState();
// }

// class _TextToSpeechScreenState extends State<TextToSpeechScreen> {
//   final FlutterTts flutterTts = FlutterTts();
//   final TextEditingController textController = TextEditingController();

//   Future _speak(String text) async {
//     if (text.isNotEmpty) {
//       await flutterTts.setLanguage("en-US");
//       await flutterTts.setPitch(1.0);
//       await flutterTts.speak(text);
//     }
//   }

//   @override
//   void dispose() {
//     flutterTts.stop();
//     textController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Text to Voice')),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: textController,
//               decoration: InputDecoration(
//                 labelText: "Enter text to speak",
//                 border: OutlineInputBorder(),
//               ),
//               maxLines: 3,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => _speak(textController.text),
//               child: Text("Speak"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
