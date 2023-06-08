import 'package:flutter_tts/flutter_tts.dart';
import 'package:ping_pong_app/domain/logic/command.dart';
import 'package:ping_pong_app/domain/logic/scorer.dart';

class CommandToSpeechHandler {
  CommandToSpeechHandler({
    required this.scorers,
  });

  final (Scorer, Scorer) scorers;

  final _flutterTts = FlutterTts();

  void handleCommand(Command command) async {
    final String? text = switch (command) {
      StartCommand() => 'Игра начинается',
      ScoreCommand() => 'Текущий счет ${scorers.$1.score}:${scorers.$2.score}',
      PointCommand(recipient: final r) => 'Очко $r',
      _ => null,
    };

    if (text != null) {
      _flutterTts.setLanguage('ru-RU');
      _flutterTts.speak(text);
    }
  }
}
