import 'package:bloc/bloc.dart';
import '../../domain/usecases/get_logged_user_use_case.dart';
import '../../domain/usecases/sign_in_use_case.dart';
import '../../domain/usecases/sign_out_use_case.dart';
import '../../domain/usecases/sign_up_use_case.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase _signUpUseCase;
  final SignInUseCase _signInUseCase;
  final SignOutUseCase _signOutUseCase;
  final GetLoggedUserUseCase _getLoggedUserUseCase;

  AuthBloc(
    this._signUpUseCase,
    this._signInUseCase,
    this._signOutUseCase,
    this._getLoggedUserUseCase,
  ) : super(const AuthInitialState()) {
    on<SignUpEvent>(_signUp);
    on<SignInEvent>(_signIn);
    on<SignOutEvent>(_signOut);
    on<CheckLoginEvent>(_checkLogin);
  }

  Future<void> _signUp(
    SignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoadingState());
    final result = await _signUpUseCase(
      email: event.email,
      password: event.password,
    );
    result.fold(
      (failure) => emit(AuthErrorState(message: failure.message)),
      (user) => emit(AuthSuccessState(user: user)),
    );
  }

  Future<void> _signIn(
    SignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoadingState());
    final result = await _signInUseCase(
      email: event.email,
      password: event.password,
    );
    result.fold(
      (failure) => emit(AuthErrorState(message: failure.message)),
      (user) => emit(AuthSuccessState(user: user)),
    );
  }

  Future<void> _signOut(
    SignOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _signOutUseCase();
    result.fold(
      (failure) => emit(AuthErrorState(message: failure.message)),
      (user) => emit(const SignedOutState()),
    );
  }

  Future<void> _checkLogin(
    CheckLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _getLoggedUserUseCase();
    result.fold(
      (_) => null,
      (user) => emit(AuthSuccessState(user: user)),
    );
  }
}
