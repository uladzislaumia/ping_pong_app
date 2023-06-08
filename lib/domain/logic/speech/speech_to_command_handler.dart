import 'dart:async';

import 'package:ping_pong_app/domain/logic/command.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToCommandHandler {
  SpeechToCommandHandler({
    required this.playerName1,
    required this.playerName2,
  }) {
    _broadcastStream = _commandController.stream.asBroadcastStream();
  }

  final String playerName1;
  final String playerName2;

  final _speechToText = SpeechToText();
  bool _isCurrentSpeechResultHandled = false;
  final _commandController = StreamController<Command>();
  late final Stream<Command> _broadcastStream;

  Stream<Command> get commands => _broadcastStream;

  Future<bool> run() async {
    final isAvailable = await _speechToText.initialize(
      onStatus: _onSpeechStatus,
      debugLogging: true,
      finalTimeout: const Duration(seconds: 5),
      onError: (e) => print(e.errorMsg),
    );

    if (isAvailable) {
      _start();
    } else {
      _stop();
    }

    return isAvailable;
  }

  Future<void> dispose() async {
    await _speechToText.cancel();
    await _commandController.close();
  }

  Future<void> _start() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      listenFor: const Duration(seconds: 3),
      listenMode: ListenMode.dictation,
    );
    _isCurrentSpeechResultHandled = false;
  }

  Future<void> _stop() {
    return _speechToText.stop();
  }

  void _onSpeechStatus(String status) async {
    if (_speechToText.isNotListening) {
      await _speechToText.cancel();
      await run();
    }
  }

  void _onSpeechResult(SpeechRecognitionResult result) async {
    if (_isCurrentSpeechResultHandled) return;

    final words = result.recognizedWords;

    Command? command;
    switch (words) {
      case 'start' || 'go' || 'launch':
        command = const StartCommand();
        break;
      case 'score' || 'check':
        command = const ScoreCommand();
        break;
      default:
        if (words == 'first') {
          command = PointCommand(recipient: playerName1);
        } else if (words == 'second') {
          command = PointCommand(recipient: playerName2);
        } else {
          command = UnknownCommand(text: words);
        }
    }

    _commandController.add(command);
    _isCurrentSpeechResultHandled = true;
    await _speechToText.cancel();
    await run();
  }
}
