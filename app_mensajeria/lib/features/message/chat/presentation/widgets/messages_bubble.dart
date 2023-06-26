import 'package:app_mensajeria/features/message/chat/presentation/widgets/audio_message.dart';
import 'package:app_mensajeria/features/message/chat/presentation/widgets/video_message.dart';
import 'package:app_mensajeria/styles.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String text;
  final String typeimage;
  final String typevideo;
  final String typeaudio;
  final bool isCurrentUser;

  MessageBubble(
      {super.key,
      required this.text,
      required this.typeimage,
      required this.typevideo,
      required this.typeaudio,
      required this.isCurrentUser});

  final player = AudioPlayer();
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            margin: EdgeInsets.only(right: 15),
            child: Column(
              crossAxisAlignment: isCurrentUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                if (text.isNotEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: DarkModeColors.accentColor,
                    ),
                    child: Text(
                      text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                const SizedBox(height: 5),
                if (typeimage != '')
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      width: 180,
                      height: 140,
                      child: Image.network(
                        typeimage!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                if (typevideo != '')
                  VideoMessage(
                    videoUrl: typevideo,
                  ),
                if (typeaudio != '')
                  AudioMessage(
                    audioUrl: typeaudio,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
