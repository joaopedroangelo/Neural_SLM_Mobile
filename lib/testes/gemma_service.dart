import 'dart:async';
import 'package:flutter_gemma/core/chat.dart';
import 'package:flutter_gemma/flutter_gemma.dart';

class GemmaLocalService {
  final InferenceChat _chat;
  bool _isFirstCall = true;

  // Defina seu prompt de sistema aqui:
  static const String _systemPrompt = '''
Você é um Assistente Médico Robô.
• Responda sempre de forma clara e objetiva.
• Seja empático e explique termos técnicos de maneira acessível.
''';

  GemmaLocalService(this._chat);

  Future<void> addQueryChunk(Message message) => _chat.addQueryChunk(message);

  Stream<String> processMessageAsync(Message message) async* {
    // Na primeira chamada, injeta o prompt de sistema
    if (_isFirstCall) {
      await _chat.addQueryChunk(
        Message.text(text: _systemPrompt, isUser: false),
      );
      _isFirstCall = false;
    }

    // Em seguida, injeta a mensagem do usuário
    await _chat.addQueryChunk(message);

    // E então retorna o stream de tokens de resposta
    yield* _chat.generateChatResponseAsync();
  }
}
