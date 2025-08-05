import 'dart:io';
import 'package:flutter_app/testes/avaliable_models.dart';
import 'package:flutter_app/testes/chat/chat_screen.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_app/services/tflite/tflite_helper.dart';
import 'package:flutter_app/features/skin_cancer/skin_cancer_labels.dart';

class SkinCancer extends StatefulWidget {
  const SkinCancer({super.key});

  @override
  State<SkinCancer> createState() => _SkinCancerState();
}

class _SkinCancerState extends State<SkinCancer> {
  File? _image;
  String _result = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  Future<void> _loadModel() async {
    await TFLiteHelper.init(
      'assets/skin_cancer/models/skin_cancer_model.tflite',
    );
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile == null) return;

    setState(() {
      _image = File(pickedFile.path);
      _isLoading = true;
      _result = '';
    });

    try {
      final labelCode = await TFLiteHelper.classifyImage(_image!);
      final mappedResult = SkinCancerLabels.mapLabel(labelCode);
      setState(() {
        _result = mappedResult;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _result = "Erro ao classificar imagem: $e";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFF5F5F5);
    const primary = Color(0xFF4DB6AC);
    const textDark = Color(0xFF333333);

    return NeumorphicBackground(
      child: NeumorphicTheme(
        theme: NeumorphicThemeData(
          baseColor: bg,
          lightSource: LightSource.topLeft,
          depth: 6,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Análise de Lesão de Pele'),
            backgroundColor: primary,
            elevation: 0,
          ),
          body: Column(
            children: [
              // Quando há imagem, mostramos a imagem no topo
              if (_image != null)
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Neumorphic(
                      style: NeumorphicStyle(
                        color: bg,
                        depth: -4,
                        boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(16),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.file(_image!, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                )
              else
                // Caso não tenha imagem, centraliza o botão na tela
                Expanded(
                  child: Center(
                    child: NeumorphicButton(
                      onPressed: _pickImage,
                      style: NeumorphicStyle(
                        color: bg,
                        boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(12),
                        ),
                        depth: 4,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 14,
                      ),
                      child: const Text(
                        'Escolher Imagem',
                        style: TextStyle(
                          color: textDark,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),

              if (_isLoading)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: LinearProgressIndicator(),
                ),

              if (_result.isNotEmpty)
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Neumorphic(
                      style: NeumorphicStyle(
                        color: bg,
                        depth: -4,
                        boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(12),
                        ),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Markdown(data: _result),
                    ),
                  ),
                ),

              if (_result.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: NeumorphicButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ChatScreen(model: Model.llama3_2_1bInstruct),
                        ),
                      );
                    },
                    style: NeumorphicStyle(
                      color: primary,
                      boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(12),
                      ),
                      depth: 4,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 14,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.chat, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Conversar com o Médico R',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              if (_image != null)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: NeumorphicButton(
                    onPressed: _pickImage,
                    style: NeumorphicStyle(
                      color: bg,
                      boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(12),
                      ),
                      depth: 4,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 14,
                    ),
                    child: const Text(
                      'Escolher outra Imagem',
                      style: TextStyle(
                        color: textDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
