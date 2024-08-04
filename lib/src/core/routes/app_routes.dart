import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/authentication/presentation/bloc/auth_bloc.dart';
import '../../features/authentication/presentation/bloc/auth_event.dart';
import '../../features/authentication/presentation/pages/sign_in_page.dart';
import '../../features/home/presentation/bloc/todo_bloc.dart';
import '../../features/home/presentation/bloc/todo_event.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/authentication/presentation/pages/sign_up_page.dart';
import '../../features/onboarding/presentation/bloc/onboarding_bloc.dart';
import '../../features/onboarding/presentation/bloc/onboarding_event.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../di/injection_container.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  static const String onboarding = '/';
  static const String home = '/home';
  static const String signUp = '/signUp';
  static const String signIn = '/signIn';

  static Route<dynamic>? generate(RouteSettings settings) {
    late final WidgetBuilder builder;
    switch (settings.name) {
      case AppRoutes.onboarding:
        builder = (_) => BlocProvider<OnboardingBloc>(
              create: (_) =>
                  getIt<OnboardingBloc>()..add(const CheckFirstAccessEvent()),
              child: const OnboardingPage(),
            );
        break;
      case AppRoutes.home:
        builder = (_) => MultiBlocProvider(
              providers: [
                BlocProvider<TodoBloc>(
                  create: (_) => getIt<TodoBloc>()..add(const GetTodosEvent()),
                ),
                BlocProvider<AuthBloc>(
                  create: (_) => getIt<AuthBloc>(),
                  child: const SignUpPage(),
                ),
              ],
              child: const HomePage(),
            );
        break;
      case AppRoutes.signUp:
        builder = (_) => BlocProvider<AuthBloc>(
              create: (_) => getIt<AuthBloc>(),
              child: const SignUpPage(),
            );
        break;
      case AppRoutes.signIn:
        builder = (_) => BlocProvider<AuthBloc>(
              create: (_) => getIt<AuthBloc>()..add(const CheckLoginEvent()),
              child: const SignInPage(),
            );
        break;
    }
    return MaterialPageRoute(
      builder: builder,
    );
  }
}
