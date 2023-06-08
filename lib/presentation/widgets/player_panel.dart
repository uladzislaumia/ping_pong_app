import 'package:flutter/widgets.dart';
import 'package:ping_pong_app/domain/logic/scorer.dart';
import 'package:ping_pong_app/presentation/widgets/counter_button.dart';

class PlayerPanel extends StatelessWidget {
  const PlayerPanel({
    super.key,
    required this.playerName,
    required this.scorer,
  });

  final String playerName;
  final Scorer scorer;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CounterButton.decrement(
          scorer: scorer,
        ),
        Text(
          playerName,
        ),
        CounterButton.increment(
          scorer: scorer,
        ),
      ],
    );
  }
}
