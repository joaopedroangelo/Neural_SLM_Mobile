import 'dart:io';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
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
    final isUser = message.isUser;
    final alignment = isUser ? Alignment.centerRight : Alignment.centerLeft;
    final bgColor = isUser ? const Color(0xFF4DB6AC) : const Color(0xFFE0E0E0);
    final textColor = isUser ? Colors.white : Colors.black87;
    final borderRadius = isUser
        ? const BorderRadius.only(
            topLeft: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )
        : const BorderRadius.only(
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
            topLeft: Radius.circular(16),
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
        style: TextStyle(
          fontSize: 16,
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      );
    }

    return Align(
      alignment: alignment,
      child: Neumorphic(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: message.imageFile == null
            ? const EdgeInsets.symmetric(horizontal: 14, vertical: 12)
            : EdgeInsets.zero,
        style: NeumorphicStyle(
          color: bgColor,
          depth: 4,
          boxShape: NeumorphicBoxShape.roundRect(borderRadius),
        ),
        child: content,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color backgroundSoftGray = Color(0xFFF5F5F5);
    const Color aquaGreen = Color(0xFF4DB6AC);

    return NeumorphicBackground(
      child: NeumorphicTheme(
        theme: NeumorphicThemeData(
          baseColor: backgroundSoftGray,
          lightSource: LightSource.topLeft,
          depth: 6,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Assistente Médico',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) =>
                        _buildMessageWidget(_messages[index]),
                  ),
                ),
                const SizedBox(height: 10),
                Neumorphic(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  style: NeumorphicStyle(
                    depth: -5,
                    boxShape: NeumorphicBoxShape.stadium(),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      NeumorphicButton(
                        onPressed: _sendImage,
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.flat,
                          boxShape: const NeumorphicBoxShape.circle(),
                          color: backgroundSoftGray,
                          depth: 4,
                        ),
                        padding: const EdgeInsets.all(10),
                        child: const Icon(Icons.image, color: aquaGreen),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          onSubmitted: (_) => _sendMessage(),
                          decoration: const InputDecoration.collapsed(
                            hintText: 'Digite sua mensagem...',
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      NeumorphicButton(
                        onPressed: _sendMessage,
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.flat,
                          boxShape: const NeumorphicBoxShape.circle(),
                          color: backgroundSoftGray,
                          depth: 4,
                        ),
                        padding: const EdgeInsets.all(10),
                        child: const Icon(Icons.send, color: aquaGreen),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
