import 'dart:io';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class TFLiteHelper {
  static late Interpreter _interpreter;
  static bool _isInitialized = false;

  static Future<void> init(String modelPath) async {
    try {
      _interpreter = await Interpreter.fromAsset(modelPath);
      _isInitialized = true;
    } catch (e) {
      print("Failed to load model from $modelPath: $e");
    }
  }

  static Interpreter get interpreter {
    if (!_isInitialized) throw Exception("Model not initialized");
    return _interpreter;
  }

  static List<dynamic> preprocessImage(File imageFile) {
    final image = img.decodeImage(imageFile.readAsBytesSync())!;
    final resizedImage = img.copyResize(image, width: 224, height: 224);

    final input = List.generate(
      1,
      (_) => List.generate(
        224,
        (_) => List.generate(224, (_) => List.filled(3, 0.0)),
      ),
    );

    for (int y = 0; y < 224; y++) {
      for (int x = 0; x < 224; x++) {
        final pixel = resizedImage.getPixel(x, y);
        final r = pixel.r;
        final g = pixel.g;
        final b = pixel.b;

        input[0][y][x][0] = (r - 127.5) / 127.5;
        input[0][y][x][1] = (g - 127.5) / 127.5;
        input[0][y][x][2] = (b - 127.5) / 127.5;
      }
    }

    return input;
  }

  static Future<String> classifyImage(File imageFile) async {
    if (!_isInitialized) throw Exception("Model not initialized");

    final input = preprocessImage(imageFile);
    final output = List.generate(1, (_) => List.filled(5, 0.0));

    _interpreter.run(input, output);

    final labelsTxt = await rootBundle.loadString(
      'assets/skin_cancer/labels/skin_cancer_labels.txt',
    );
    final labelList = labelsTxt
        .split('\n')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    double maxScore = output[0][0];
    int maxIndex = 0;

    for (int i = 1; i < output[0].length; i++) {
      if (output[0][i] > maxScore) {
        maxScore = output[0][i];
        maxIndex = i;
      }
    }

    return labelList[maxIndex];
  }
}
