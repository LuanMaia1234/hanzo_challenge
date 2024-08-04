import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/routes/app_routes.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_state.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if (state is OnboardingAlreadyAccessedState) {
          navigatorKey.currentState!.pushReplacementNamed(
            AppRoutes.signIn,
          );
        }
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lottie/onboarding.json',
              height: 256,
              width: 256,
            ),
            const Text(
              'Olá',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Bem vindo ao Hanzo Challenge, onde você gerencia suas tarefas.',
              style: TextStyle(color: Colors.grey, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: FilledButton(
                onPressed: () {
                  navigatorKey.currentState!.pushNamed(
                    AppRoutes.signIn,
                  );
                },
                child: const Text('Login'),
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: OutlinedButton(
                onPressed: () {
                  navigatorKey.currentState!.pushNamed(
                    AppRoutes.signUp,
                  );
                },
                child: const Text('Cadastrar'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
