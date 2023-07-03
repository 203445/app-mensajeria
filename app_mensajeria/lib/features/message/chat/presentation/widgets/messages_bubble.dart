import 'package:app_mensajeria/features/message/chat/presentation/widgets/audio_message.dart';
import 'package:app_mensajeria/features/message/chat/presentation/widgets/video_message.dart';
import 'package:app_mensajeria/styles.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String text;
  final String typeimage;
  final String typevideo;
  final String typeaudio;
  final String typegif;
  final String typepdf;
  final bool isCurrentUser;

  Message(
      {super.key,
      required this.text,
      required this.typeimage,
      required this.typevideo,
      required this.typeaudio,
      required this.typegif,
      required this.typepdf,
      required this.isCurrentUser});

  final player = AudioPlayer();
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    Color getChatBubbleColor(BuildContext context, bool isCurrentUser) {
      final theme = Theme.of(context).brightness;

      if (theme == Brightness.dark) {
        return isCurrentUser
            ? DarkModeColors.accentColor
            : DarkModeColors.textfill;
      } else {
        return isCurrentUser
            ? LightModeColors.accentColor
            : LightModeColors.textColor;
      }
    }

    return Row(
      mainAxisAlignment:
          isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            margin: const EdgeInsets.only(right: 15, left: 15),
            child: Column(
              crossAxisAlignment: isCurrentUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                if (text.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: getChatBubbleColor(context, isCurrentUser),
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
                        typeimage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                if (typegif.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      width: 180,
                      height: 140,
                      child: Image.network(
                        typegif,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
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
