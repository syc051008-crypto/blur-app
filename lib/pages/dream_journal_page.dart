import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class DreamJournalPage extends StatefulWidget {
  const DreamJournalPage({super.key});

  @override
  State<DreamJournalPage> createState() => _DreamJournalPageState();
}

class _DreamJournalPageState extends State<DreamJournalPage> {
  late stt.SpeechToText speech;

  bool isListening = false;

  final TextEditingController dreamController = TextEditingController();

  @override
  void initState() {
    super.initState();
    speech = stt.SpeechToText();
  }

  @override
  void dispose() {
    dreamController.dispose();
    super.dispose();
  }

  void listen() async {
    if (!isListening) {
      final available = await speech.initialize();

      if (available) {
        setState(() {
          isListening = true;
        });

        speech.listen(
          localeId: 'ko_KR',
          onResult: (result) {
            setState(() {
              dreamController.text = result.recognizedWords;
            });
          },
        );
      }
    } else {
      setState(() {
        isListening = false;
      });

      speech.stop();
    }
  }

  void saveDream() async {
    final content = dreamController.text.trim();

    if (content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('꿈 내용을 입력해주세요.'),
        ),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('dreams').add({
        'content': content,
        'timestamp': FieldValue.serverTimestamp(),
        'isPublic': false,
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('꿈이 저장되었습니다.'),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('저장 중 오류가 발생했습니다: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F2FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F2FF),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0xFF3B3355),
        ),
        title: const Text(
          '꿈 기록하기',
          style: TextStyle(
            color: Color(0xFF3B3355),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.75),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: const Color(0xFFE2D7FF),
                ),
              ),
              child: TextField(
                controller: dreamController,
                minLines: 12,
                maxLines: 18,
                style: const TextStyle(
                  color: Color(0xFF3B3355),
                  fontSize: 16,
                  height: 1.5,
                ),
                decoration: const InputDecoration(
                  hintText: '어젯밤 꾼 꿈을 기록해보세요...',
                  hintStyle: TextStyle(
                    color: Color(0xFF9A8DB8),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: listen,
                    icon: Icon(
                      isListening ? Icons.mic : Icons.mic_none,
                    ),
                    label: Text(
                      isListening ? '듣는 중...' : '음성 기록',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isListening
                          ? const Color(0xFFE85D75)
                          : const Color(0xFFB89CFF),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 58),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: ElevatedButton(
                    onPressed: saveDream,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6D5A9D),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 58),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                    child: const Text(
                      '저장하기',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}