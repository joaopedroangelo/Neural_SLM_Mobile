import 'package:flutter/foundation.dart';
import '../features/home/home_page.dart';
import 'package:flutter_gemma/pigeon.g.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'chat/chat_screen.dart';
import 'model_download_screen.dart';
import 'avaliable_models.dart';

class ModelSelectionScreen extends StatelessWidget {
  const ModelSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final models = Model.values.where((model) {
      if (model.localModel) {
        return true;
      }
      if (!kIsWeb) return true;
      return model.preferredBackend == PreferredBackend.gpu && !model.needsAuth;
    }).toList();

    const Color backgroundSoftGray = Color(0xFFF5F5F5);
    const Color aquaGreenConsistent = Color(0xFF4DB6AC);
    const Color textDarkGray = Color(0xFF333333);

    return NeumorphicBackground(
      child: NeumorphicTheme(
        theme: NeumorphicThemeData(
          baseColor: backgroundSoftGray,
          lightSource: LightSource.topLeft,
          depth: 8,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: NeumorphicAppBar(
            title: const Text(
              'Selecione um modelo',
              style: TextStyle(
                color: textDarkGray,
                fontWeight: FontWeight.w600,
              ),
            ),
            iconTheme: const IconThemeData(color: aquaGreenConsistent),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: ListView.separated(
              itemCount: models.length + 1, // +1 para o botão "Voltar"
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                if (index < models.length) {
                  final model = models[index];
                  return NeumorphicButton(
                    onPressed: () {
                      if (model.localModel) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(model: model),
                          ),
                        );
                      } else if (!kIsWeb) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ModelDownloadScreen(model: model),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(model: model),
                          ),
                        );
                      }
                    },
                    style: NeumorphicStyle(
                      color: Colors.white,
                      depth: 6,
                      boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(16),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 16,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.memory,
                            size: 32,
                            color: aquaGreenConsistent,
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              model.displayName,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: textDarkGray,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: aquaGreenConsistent,
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  // Botão extra "Voltar ao menu principal"
                  return NeumorphicButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(title: ''),
                        ),
                        (route) => false,
                      );
                    },
                    style: NeumorphicStyle(
                      color: Colors.white,
                      depth: 6,
                      boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(16),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 16,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.home,
                            size: 32,
                            color: aquaGreenConsistent,
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              'Voltar ao menu principal',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: textDarkGray,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                            color: aquaGreenConsistent,
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
