import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../../usecase_config.dart';
import '../../data/models/chats_model.dart';
import '../../domain/entities/chats.dart';

class ChatDetailPage extends StatefulWidget {
  final String chatId;
  final UsecaseConfig usecaseConfig;

  ChatDetailPage({required this.chatId, required this.usecaseConfig});

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _messageController = TextEditingController();

  List<ChatModel> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _loadMessages() async {
    List<ChatModel> messages =
        await widget.usecaseConfig.getMessageUseCase!.execute(widget.chatId);
    print(messages);
    setState(() {
      _messages = messages;
    });
  }

  void _sendMessage() {
    String text = _messageController.text.trim();
    if (text.isNotEmpty) {
      ChatModel newMessage = ChatModel(
        userEmisorId: widget
            .chatId, // Aquí debes proporcionar los IDs correctos del emisor y receptor
        userReceptorId: widget.chatId,
        messages: {
          'content': text,
          'type': 0
        }, // Ajusta esto según la estructura de tus mensajes
      );
      widget.usecaseConfig.sendMessageUsecase!.execute(widget.chatId,
          newMessage as String, widget.chatId as int, widget.chatId);
      _messageController.clear();
    }
  }

  Widget _buildMessageWidget(ChatModel message) {
    return ListTile(
      title: Text(message.messages['content']),
      subtitle: Text('Type: ${message.messages['type']}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Detail'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildMessageWidget(_messages[index]);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter a message',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _sendMessage,
                  icon: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
