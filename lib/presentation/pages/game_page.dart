import 'package:flutter/material.dart';
import 'package:ping_pong_app/domain/logic/command.dart';
import 'package:ping_pong_app/domain/logic/ping_pong_rules.dart';
import 'package:ping_pong_app/domain/logic/scorer.dart';
import 'package:ping_pong_app/domain/logic/speech/command_to_speech_handler.dart';
import 'package:ping_pong_app/domain/logic/speech/speech_to_command_handler.dart';
import 'package:ping_pong_app/presentation/widgets/scoreboard.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _Content(),
    );
  }
}

class _Content extends StatefulWidget {
  const _Content();

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  final rules = PingPongRules();
  final speechToCommandHandler = SpeechToCommandHandler(
    playerName1: 'wolf',
    playerName2: 'hedgehog',
  );
  late final (Scorer, Scorer) scorers;
  late final CommandToSpeechHandler commandToSpeechHandler;

  @override
  void initState() {
    super.initState();
    scorers = (Scorer(rules), Scorer(rules));
    rules.registerScorers(scorers: scorers);
    commandToSpeechHandler = CommandToSpeechHandler(scorers: scorers);
    _init();
  }

  void _init() async {
    await speechToCommandHandler.run();
    // TODO: оформить отписку
    speechToCommandHandler.commands.listen(_commandListener);
    setState(() {});
  }

  void _commandListener(Command command) {
    commandToSpeechHandler.handleCommand(command);
    switch (command) {
      case PointCommand(recipient: final r):
        if (r == 'wolf') {
          scorers.$1.increment();
        } else if (r == 'hedgehog') {
          scorers.$2.increment();
        }
        break;
      default:
        break;
    }
  }

  void _onBack() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AnimatedBuilder(
          animation: scorers.$1,
          builder: (_, __) => AnimatedBuilder(
            animation: scorers.$2,
            builder: (_, __) => Scoreboard(
              score1: scorers.$1.score,
              score2: scorers.$2.score,
            ),
          ),
        ),
        Text(
          'start <name1> <name2> - ...\n'
          'point <name1> \n'
          'score \n',
          textAlign: TextAlign.center,
        ),
        StreamBuilder(
            stream: speechToCommandHandler.commands,
            builder: (_, snapshot) => switch (snapshot.data) {
                  StartCommand() => Text('start'),
                  ScoreCommand() => Text('score'),
                  PointCommand() => Text('point'),
                  UnknownCommand(text: final text) => Text(text),
                  _ => SizedBox(),
                }),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     PlayerPanel(
        //       playerName: 'Player 1',
        //       scorer: scorer1,
        //     ),
        //     PlayerPanel(
        //       playerName: 'Player 2',
        //       scorer: scorer2,
        //     ),
        //   ],
        // ),
        Center(
          child: ElevatedButton(
            onPressed: _onBack,
            child: const Text('Save game'),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    scorers.$1.dispose();
    scorers.$2.dispose();
    speechToCommandHandler.dispose();
    super.dispose();
  }
}
