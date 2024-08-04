import 'package:equatable/equatable.dart';
import 'package:hanzo_challenge/src/features/authentication/domain/entities/user_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {
  const AuthInitialState();
}

class AuthLoadingState extends AuthState {
  const AuthLoadingState();
}

class AuthSuccessState extends AuthState {
  const AuthSuccessState({
    required this.user,
  });

  final UserEntity user;

  @override
  List<Object?> get props => [user];
}

class AuthErrorState extends AuthState {
  const AuthErrorState({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

class SignedOutState extends AuthState {
  const SignedOutState();
}



