import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class Message {
  final String? text;
  final File? imageFile;
  final bool isUser;

  Message({this.text, this.imageFile, required this.isUser});
}

class _ChatPageState extends State<ChatPage> {
  final List<Message> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(Message(text: text, isUser: true));
      _messages.add(Message(text: "Resposta automática: $text", isUser: false));
    });

    _controller.clear();
  }

  Future<void> _sendImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile == null) return;

    setState(() {
      _messages.add(Message(imageFile: File(pickedFile.path), isUser: true));
      _messages.add(Message(text: "Legal imagem!", isUser: false));
    });
  }

  Widget _buildMessageWidget(Message message) {
    final alignment = message.isUser
        ? Alignment.centerRight
        : Alignment.centerLeft;
    final bgColor = message.isUser ? const Color(0xFF50A3C4) : Colors.grey[200];
    final textColor = message.isUser ? Colors.white : Colors.black87;
    final borderRadius = message.isUser
        ? const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
          );

    Widget content;
    if (message.imageFile != null) {
      content = ClipRRect(
        borderRadius: borderRadius,
        child: Image.file(
          message.imageFile!,
          width: 200,
          height: 200,
          fit: BoxFit.cover,
        ),
      );
    } else {
      content = Text(
        message.text ?? '',
        style: GoogleFonts.poppins(color: textColor, fontSize: 16),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Align(
        alignment: alignment,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: message.imageFile == null
              ? const EdgeInsets.all(12)
              : EdgeInsets.zero,
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: borderRadius,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: content,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F9FB),
      appBar: AppBar(
        title: const Text('Assistente Médico'),
        backgroundColor: const Color(0xFF50A3C4),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, index) =>
                  _buildMessageWidget(_messages[index]),
            ),
          ),
          const Divider(height: 1),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.image),
                  color: const Color(0xFF50A3C4),
                  onPressed: _sendImage,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F0F0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Digite sua mensagem...',
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: const Color(0xFF50A3C4),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
