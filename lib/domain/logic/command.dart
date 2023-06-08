sealed class Command {
  const Command();
}

class StartCommand extends Command {
  const StartCommand();
}

class PointCommand extends Command {
  const PointCommand({
    required this.recipient,
  });

  final String recipient;
}

class ScoreCommand extends Command {
  const ScoreCommand();
}

class UnknownCommand extends Command {
  const UnknownCommand({
    required this.text,
  });

  final String text;
}
