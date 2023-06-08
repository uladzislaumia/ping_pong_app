import 'package:flutter/material.dart';

class TextStyles extends ThemeExtension<TextStyles> {
  const TextStyles({
    required this.scoreTextStyle,
  });

  final TextStyle? scoreTextStyle;

  static const base = TextStyles(
    scoreTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 50,
    ),
  );

  @override
  ThemeExtension<TextStyles> copyWith({
    TextStyle? scoreTextStyle,
  }) {
    return TextStyles(
      scoreTextStyle: scoreTextStyle ?? this.scoreTextStyle,
    );
  }

  @override
  ThemeExtension<TextStyles> lerp(
    TextStyles? other,
    double t,
  ) {
    return TextStyles(
      scoreTextStyle: TextStyle.lerp(scoreTextStyle, other?.scoreTextStyle, t),
    );
  }
}
