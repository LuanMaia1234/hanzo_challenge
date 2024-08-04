import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/authentication/data/datasources/auth_data_source.dart';
import '../../features/authentication/data/datasources/firebase_auth_data_source_impl.dart';
import '../../features/authentication/data/repositories/auth_repository_impl.dart';
import '../../features/authentication/domain/repositories/auth_repository.dart';
import '../../features/authentication/domain/usecases/get_logged_user_use_case.dart';
import '../../features/authentication/domain/usecases/sign_in_use_case.dart';
import '../../features/authentication/domain/usecases/sign_out_use_case.dart';
import '../../features/authentication/domain/usecases/sign_up_use_case.dart';
import '../../features/authentication/presentation/bloc/auth_bloc.dart';
import '../../features/home/data/datasources/todo_data_source.dart';
import '../../features/home/data/datasources/todo_data_source_impl.dart';
import '../../features/home/data/repositories/todo_repository_impl.dart';
import '../../features/home/domain/repositories/todo_repository.dart';
import '../../features/home/domain/usecases/get_todos_use_case.dart';
import '../../features/home/presentation/bloc/todo_bloc.dart';
import '../../features/onboarding/presentation/bloc/onboarding_bloc.dart';
import '../constants/constants.dart';
import '../utils/storage/shared_preferences_impl.dart';
import '../utils/storage/simple_data.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  getIt.registerLazySingleton<SimpleData>(
    () => SharedPreferencesImpl(sharedPreferences),
  );

  //Onboarding
  getIt.registerFactory(() => OnboardingBloc(getIt()));

  //Auth
  getIt.registerLazySingleton<AuthDataSource>(
    () => FirebaseAuthDataSourceImpl(FirebaseAuth.instance),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(getIt()),
  );

  getIt.registerLazySingleton<SignInUseCase>(
    () => SignInUseCase(getIt()),
  );

  getIt.registerLazySingleton<SignOutUseCase>(
    () => SignOutUseCase(getIt()),
  );

  getIt.registerLazySingleton<GetLoggedUserUseCase>(
    () => GetLoggedUserUseCase(getIt()),
  );

  getIt.registerFactory(() => AuthBloc(getIt(), getIt(), getIt(), getIt()));

  //Home
  getIt.registerLazySingleton<TodoDataSource>(
    () => TodoDataSourceImpl(Dio(BaseOptions(baseUrl: Constants.baseUrl))),
  );

  getIt.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton<GetTodosUseCase>(
    () => GetTodosUseCase(getIt()),
  );

  getIt.registerFactory(() => TodoBloc(getIt()));
}
