import 'package:bloc/bloc.dart';

import '../../../../core/utils/storage/simple_data.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final SimpleData _simpleData;

  OnboardingBloc(this._simpleData) : super(const OnboardingInitialState()) {
    on<CheckFirstAccessEvent>(_checkFirstAccess);
  }

  Future<void> _checkFirstAccess(
    CheckFirstAccessEvent event,
    Emitter<OnboardingState> emit,
  ) async {
    final isFirstAccess = await _simpleData.getFirstAccess();
    if (isFirstAccess) {
      _simpleData.setFirstAccess(false);
    } else {
      emit(const OnboardingAlreadyAccessedState());
    }
  }
}
