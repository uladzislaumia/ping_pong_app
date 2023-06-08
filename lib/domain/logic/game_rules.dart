import 'package:ping_pong_app/domain/logic/scorer.dart';

abstract class GameRules {
  bool isIncrementAllowed(Scorer scorer);
  bool isDecrementAllowed(Scorer scorer);
}
