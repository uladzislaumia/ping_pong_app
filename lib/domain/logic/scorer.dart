import 'package:flutter/widgets.dart';
import 'package:ping_pong_app/domain/logic/game_rules.dart';

class Scorer with ChangeNotifier {
  Scorer(this.rules);

  final GameRules rules;

  var _score = 0;
  int get score => _score;

  void increment() {
    if (rules.isIncrementAllowed(this)) {
      _score++;
      notifyListeners();
    }
  }

  void decrement() {
    if (rules.isDecrementAllowed(this)) {
      _score--;
      notifyListeners();
    }
  }
}
