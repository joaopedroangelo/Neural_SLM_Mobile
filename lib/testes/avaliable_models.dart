import 'package:flutter_gemma/core/model.dart';
import 'package:flutter_gemma/pigeon.g.dart';

enum Model {
  // Models from JSON - Gemma 3n E2B (Updated version)
  gemma3nGpu_2B(
    url:
        'https://huggingface.co/google/gemma-3n-E2B-it-litert-preview/resolve/main/gemma-3n-E2B-it-int4.task',
    filename: 'gemma-3n-E2B-it-int4.task',
    displayName: 'Gemma 3n E2B IT Multimodal (GPU) 3.1Gb',
    licenseUrl: 'https://huggingface.co/google/gemma-3n-E2B-it-litert-preview',
    needsAuth: true,
    preferredBackend: PreferredBackend.gpu,
    modelType: ModelType.gemmaIt,
    temperature: 1.0,
    topK: 64,
    topP: 0.95,
    supportImage: true,
    maxTokens: 4096,
    maxNumImages: 1,
  ),
  gemma3nCpu_2B(
    url:
        'https://huggingface.co/google/gemma-3n-E2B-it-litert-preview/resolve/main/gemma-3n-E2B-it-int4.task',
    filename: 'gemma-3n-E2B-it-int4.task',
    displayName: 'Gemma 3n E2B IT Multimodal (CPU) 3.1Gb',
    licenseUrl: 'https://huggingface.co/google/gemma-3n-E2B-it-litert-preview',
    needsAuth: true,
    preferredBackend: PreferredBackend.cpu,
    modelType: ModelType.gemmaIt,
    temperature: 1.0,
    topK: 64,
    topP: 0.95,
    supportImage: true,
    maxTokens: 4096,
    maxNumImages: 1,
  ),

  llama3_2_3bInstruct(
    url:
        'https://huggingface.co/litert-community/Llama-3.2-3B-Instruct/resolve/main/Llama-3.2-3B-Instruct_multi-prefill-seq_q8_ekv1280.task',
    filename: 'Llama-3.2-3B-Instruct_multi-prefill-seq_q8_ekv1280.task',
    displayName: 'Llama 3.2 3B Instruct (Quantized Q8 EKV1280)',
    licenseUrl: 'https://huggingface.co/litert-community/Llama-3.2-3B-Instruct',
    needsAuth: true,
    preferredBackend: PreferredBackend.cpu,
    modelType: ModelType.general,
    temperature: 1.0,
    topK: 40,
    topP: 0.9,
    supportImage: false,
    maxTokens: 2048,
    maxNumImages: 0,
  ),

  llama3_2_1bInstruct(
    url:
        'https://huggingface.co/litert-community/Llama-3.2-1B-Instruct/resolve/main/Llama-3.2-1B-Instruct_multi-prefill-seq_q8_ekv1280.task',
    filename: 'Llama-3.2-1B-Instruct_multi-prefill-seq_q8_ekv1280.task',
    displayName: 'Llama 3.2 1B Instruct (Quantized Q8 EKV1280)',
    licenseUrl: 'https://huggingface.co/litert-community/Llama-3.2-1B-Instruct',
    needsAuth: true,
    preferredBackend: PreferredBackend.cpu,
    modelType: ModelType.general,
    temperature: 1.0,
    topK: 40,
    topP: 0.9,
    supportImage: false,
    maxTokens: 2048,
    maxNumImages: 0,
  );

  // Define fields for the enum
  final String url;
  final String filename;
  final String displayName;
  final String licenseUrl;
  final bool needsAuth;
  final bool localModel;
  final PreferredBackend preferredBackend;
  final ModelType modelType;
  final double temperature;
  final int topK;
  final double topP;
  final bool supportImage;
  final int maxTokens;
  final int? maxNumImages;

  // Constructor for the enum
  const Model({
    required this.url,
    required this.filename,
    required this.displayName,
    required this.licenseUrl,
    required this.needsAuth,
    // ignore: unused_element_parameter
    this.localModel = false,
    required this.preferredBackend,
    required this.modelType,
    required this.temperature,
    required this.topK,
    required this.topP,
    this.supportImage = false,
    this.maxTokens = 1024,
    this.maxNumImages,
  });
}
