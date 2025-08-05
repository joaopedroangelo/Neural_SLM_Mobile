import 'package:flutter/material.dart';
import 'package:flutter_gemma/flutter_gemma.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    // Aqui message.text já é String, então podemos usar diretamente:
    final textToShow = message.text;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: message.isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: <Widget>[
          if (!message.isUser) _buildAvatar(),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: message.isUser
                    ? const Color(0xFF1a4a7c)
                    : const Color.fromARGB(230, 69, 69, 69),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Se tiver imagem, exibe antes do texto
                  if (message.hasImage) ...[
                    _buildImageWidget(context),
                    if (textToShow.isNotEmpty) const SizedBox(height: 8),
                  ],

                  // Texto via Markdown
                  if (textToShow.isNotEmpty)
                    MarkdownBody(
                      data: textToShow,
                      styleSheet: MarkdownStyleSheet(
                        p: TextStyle(
                          color: message.isUser
                              ? Colors.white
                              : const Color.fromARGB(230, 255, 255, 255),
                          fontSize: 14,
                        ),
                        code: TextStyle(
                          backgroundColor: message.isUser
                              ? const Color(0xFF2a5a8c)
                              : const Color(0xFF404040),
                          color: Colors.white,
                        ),
                        codeblockDecoration: BoxDecoration(
                          color: message.isUser
                              ? const Color(0xFF2a5a8c)
                              : const Color(0xFF404040),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    )
                  // Caso contrário, mostra indicador de carregamento
                  else if (!message.hasImage)
                    const Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          if (message.isUser) _buildAvatar(),
        ],
      ),
    );
  }

  Widget _buildImageWidget(BuildContext context) {
    return GestureDetector(
      onTap: () => _showImageDialog(context),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 300, maxHeight: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.memory(
            message.imageBytes!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 200,
                height: 100,
                color: Colors.grey[300],
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, color: Colors.red),
                    SizedBox(height: 4),
                    Text(
                      'Erro carregando imagem',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showImageDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext ctx) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Center(
                child: InteractiveViewer(
                  child: Image.memory(message.imageBytes!, fit: BoxFit.contain),
                ),
              ),
              Positioned(
                top: 40,
                right: 20,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () => Navigator.of(ctx).pop(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAvatar() {
    return message.isUser
        ? const CircleAvatar(
            backgroundColor: Color(0xFF1a4a7c),
            child: Icon(Icons.person, color: Colors.white),
          )
        : const CircleAvatar(
            backgroundColor: Colors.grey,
            child: Icon(Icons.smart_toy, color: Colors.white),
          );
  }
}
