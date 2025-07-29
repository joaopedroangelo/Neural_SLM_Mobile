import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_app/services/tflite/tflite_helper.dart';
import 'package:flutter_app/features/skin_cancer/skin_cancer_labels.dart'; // ajuste o caminho conforme seu projeto
import 'package:flutter_app/features/chat/chat_page.dart'; // import necessário para navegar

class SkinCancer extends StatefulWidget {
  const SkinCancer({super.key});

  @override
  State<SkinCancer> createState() => _SkinCancerState();
}

class _SkinCancerState extends State<SkinCancer> {
  String _status = "Carregando modelo...";
  File? _image;
  String _result = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  Future<void> _loadModel() async {
    try {
      await TFLiteHelper.init(
        'assets/skin_cancer/models/skin_cancer_model.tflite',
      );
      setState(() {
        _status = "Modelo carregado com sucesso!";
      });
    } catch (e) {
      setState(() {
        _status = "Erro ao carregar modelo: $e";
      });
    }
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
      final labelCode = await _classifyImage(_image!); // Ex: 'mel'
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

  Future<String> _classifyImage(File image) async {
    try {
      return await TFLiteHelper.classifyImage(image);
    } catch (e) {
      throw Exception("Classificação falhou: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Análise de Lesão de Pele'),
        backgroundColor: const Color(0xFF50A3C4),
      ),
      body: Column(
        children: [
          Padding(padding: const EdgeInsets.all(8.0), child: Text(_status)),
          Expanded(
            child: Center(
              child: _image != null
                  ? Image.file(_image!, fit: BoxFit.cover)
                  : const Text('Nenhuma imagem selecionada'),
            ),
          ),
          if (_isLoading) const LinearProgressIndicator(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Markdown(
                data: _result,
                // Opcional: customize o estilo aqui
              ),
            ),
          ),
          if (_result.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChatPage()),
                  );
                },
                icon: const Icon(Icons.chat),
                label: const Text('Conversar com o Médico R'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF50A3C4),
                  minimumSize: const Size.fromHeight(48),
                ),
              ),
            ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: _pickImage,
            child: const Text('Escolher Imagem'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
