import 'package:flutter/material.dart';
import 'package:ping_pong_app/domain/logic/scorer.dart';

class CounterButton extends StatelessWidget {
  const CounterButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  factory CounterButton.increment({
    required Scorer scorer,
  }) =>
      CounterButton(
        icon: Icons.plus_one_rounded,
        onPressed: scorer.increment,
      );

  factory CounterButton.decrement({
    required Scorer scorer,
  }) =>
      CounterButton(
        icon: Icons.exposure_minus_1_rounded,
        onPressed: scorer.decrement,
      );

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
      ),
    );
  }
}
