import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceInputScreen extends StatefulWidget {
  @override
  State<VoiceInputScreen> createState() => _VoiceInputScreenState();
}

class _VoiceInputScreenState extends State<VoiceInputScreen> with SingleTickerProviderStateMixin {
  SpeechToText _speech = SpeechToText();
  bool _available = false;
  bool _listening = false;
  String _spokenText = '';
  late AnimationController _glowController;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);
    _speech.initialize().then((available) {
      setState(() => _available = available);
    });
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  void _startListening() async {
    if (!_listening) {
      await _speech.listen(onResult: (result) {
        setState(() => _spokenText = result.recognizedWords);
      });
      setState(() => _listening = true);
    }
  }

  void _stopListening() async {
    await _speech.stop();
    setState(() => _listening = false);
  }

  @override
  Widget build(BuildContext context) {
    final micColor = _listening ? Colors.redAccent : Colors.teal;

    return Scaffold(
      appBar: AppBar(
        title: Text("Voice Input", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal[700],
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Press the mic and start speaking",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: _available
                        ? (_listening ? _stopListening : _startListening)
                        : null,
                    child: AnimatedBuilder(
                      animation: _glowController,
                      builder: (context, child) {
                        final scale = 1 + (_listening ? _glowController.value * 0.2 : 0.0);
                        return Transform.scale(
                          scale: scale,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: micColor,
                            child: Icon(
                              _listening ? Icons.mic_off : Icons.mic,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _spokenText.isNotEmpty ? _spokenText : "Your speech will appear here",
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
