import 'package:flutter/material.dart';
import 'package:ping_pong_app/presentation/core/themes/text_styles.dart';

class Scoreboard extends StatelessWidget {
  const Scoreboard({
    super.key,
    required this.score1,
    required this.score2,
  });

  final int score1;
  final int score2;

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).extension<TextStyles>();

    return Text(
      '$score1 : $score2',
      textAlign: TextAlign.center,
      style: textStyles?.scoreTextStyle,
    );
  }
}
