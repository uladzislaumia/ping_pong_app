import 'package:ping_pong_app/domain/logic/game_rules.dart';
import 'package:ping_pong_app/domain/logic/scorer.dart';

class PingPongRules implements GameRules {
  PingPongRules();

  late final (Scorer, Scorer) _scorers;

  void registerScorers({
    required (Scorer, Scorer) scorers,
  }) {
    _scorers = scorers;
  }

  @override
  bool isDecrementAllowed(Scorer scorer) {
    return (scorer.score > 0);
  }

  @override
  bool isIncrementAllowed(Scorer scorer) {
    return scorer.score < 11 ||
        (_scorers.$1.score - _scorers.$2.score).abs() < 2;
  }
}
