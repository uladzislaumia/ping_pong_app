import 'package:flutter/widgets.dart';
import 'package:ping_pong_app/domain/logic/scorer.dart';

class GameReferee with ChangeNotifier {
  GameReferee({
    this.minTotalScore = 0,
    this.maxTotalScore = 11,
    required this.scorer1,
    required this.scorer2,
  }) {
    scorer1.addListener(() {
      _updateTotalScore();
    });
    scorer2.addListener(() {
      _updateTotalScore();
    });
  }

  final int minTotalScore;
  final int maxTotalScore;
  final Scorer scorer1;
  final Scorer scorer2;

  var _totalScore = 0;
  int get totalScore => _totalScore;

  void _updateTotalScore() {
    _totalScore = scorer1.score + scorer2.score;
  }
}
