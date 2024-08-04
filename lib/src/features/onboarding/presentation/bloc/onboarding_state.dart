import 'package:equatable/equatable.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object?> get props => [];
}

class OnboardingInitialState extends OnboardingState {
  const OnboardingInitialState();
}

class OnboardingAlreadyAccessedState extends OnboardingState {
  const OnboardingAlreadyAccessedState();
}