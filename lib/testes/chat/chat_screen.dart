import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemma/core/chat.dart';
import 'package:flutter_gemma/flutter_gemma.dart';
import 'chat_widget.dart';
import '../avaliable_models.dart';
import 'package:path_provider/path_provider.dart';
import '../model_selection_screen.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, this.model = Model.gemma3nGpu_2B});

  final Model model;

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final _gemma = FlutterGemmaPlugin.instance;
  InferenceChat? chat;
  final _messages = <Message>[];
  bool _isModelInitialized = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initializeModel();
  }

  @override
  void dispose() {
    super.dispose();
    _gemma.modelManager.deleteModel();
  }

  Future<void> _initializeModel() async {
    if (!await _gemma.modelManager.isModelInstalled) {
      var path = widget.model.url;
      if (!kIsWeb) {
        if (widget.model.localModel) {
          path =
              '${(await getExternalStorageDirectory())?.path}/${widget.model.filename}';
        } else {
          path =
              '${(await getApplicationDocumentsDirectory()).path}/${widget.model.filename}';
        }
      }
      await _gemma.modelManager.setModelPath(path);
    }

    final model = await _gemma.createModel(
      modelType: super.widget.model.modelType,
      preferredBackend: super.widget.model.preferredBackend,
      maxTokens: 1024,
      supportImage: widget.model.supportImage,
      maxNumImages: widget.model.maxNumImages,
    );

    chat = await model.createChat(
      temperature: super.widget.model.temperature,
      randomSeed: 1,
      topK: super.widget.model.topK,
      topP: super.widget.model.topP,
      tokenBuffer: 256,
      supportImage: widget.model.supportImage,
    );

    setState(() {
      _isModelInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color backgroundSoftGray = Color(0xFFF5F5F5);
    const Color aquaGreenConsistent = Color(0xFF4DB6AC);
    const Color textDarkGray = Color(0xFF333333);

    return NeumorphicBackground(
      child: NeumorphicTheme(
        theme: NeumorphicThemeData(
          baseColor: backgroundSoftGray,
          lightSource: LightSource.topLeft,
          depth: 10,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: NeumorphicAppBar(
            leading: NeumorphicButton(
              padding: const EdgeInsets.all(8),
              style: const NeumorphicStyle(
                shape: NeumorphicShape.flat,
                boxShape: NeumorphicBoxShape.circle(),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const ModelSelectionScreen(),
                  ),
                  (route) => false,
                );
              },
              child: const Icon(Icons.arrow_back, color: aquaGreenConsistent),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Assistente Médico Robô',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: textDarkGray,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                if (chat?.supportsImages == true)
                  const Text(
                    'Suporte a imagem ativado',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.green,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
              ],
            ),
            actions: [
              if (chat?.supportsImages == true)
                const Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Icon(Icons.image, color: Colors.green, size: 20),
                ),
            ],
          ),
          body: _isModelInitialized
              ? Column(
                  children: [
                    if (_error != null)
                      _buildErrorBanner(_error!, textDarkGray),
                    if (chat?.supportsImages == true && _messages.isEmpty)
                      _buildImageSupportInfo(),
                    Expanded(
                      child: ChatListWidget(
                        chat: chat,
                        gemmaHandler: (message) {
                          setState(() {
                            _messages.add(message);
                          });
                        },
                        humanHandler: (message) {
                          setState(() {
                            _error = null;
                            _messages.add(message);
                          });
                        },
                        errorHandler: (err) {
                          setState(() {
                            _error = err;
                          });
                        },
                        messages: _messages,
                      ),
                    ),
                  ],
                )
              : const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  Widget _buildErrorBanner(String errorMessage, Color textColor) {
    return Container(
      width: double.infinity,
      color: Colors.red,
      padding: const EdgeInsets.all(8.0),
      child: Text(
        errorMessage,
        style: TextStyle(color: textColor),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildImageSupportInfo() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1a3a5c),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: Colors.green, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'O modelo suporta imagens',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Use o botão 📷 para enviar imagens',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
