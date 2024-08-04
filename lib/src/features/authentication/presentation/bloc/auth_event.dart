abstract class AuthEvent {
  const AuthEvent();
}

class SignUpEvent extends AuthEvent {
  const SignUpEvent({required this.email, required this.password});

  final String email;
  final String password;
}

class SignInEvent extends AuthEvent {
  const SignInEvent({required this.email, required this.password});

  final String email;
  final String password;
}

class SignOutEvent extends AuthEvent {
  const SignOutEvent();
}

class CheckLoginEvent extends AuthEvent {
  const CheckLoginEvent();
}

