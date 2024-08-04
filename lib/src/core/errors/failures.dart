abstract class Failure {
  final String message;

  const Failure({required this.message});
}

class ServerFailure extends Failure {
  ServerFailure(String message) : super(message: message);
}

class ExistedAccountFailure extends Failure {
  ExistedAccountFailure(String message) : super(message: message);
}

class WeekPasswordFailure extends Failure {
  WeekPasswordFailure(String message) : super(message: message);
}

class InvalidCredentialFailure extends Failure {
  InvalidCredentialFailure(String message) : super(message: message);
}
