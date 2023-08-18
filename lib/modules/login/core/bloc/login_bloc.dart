import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {

    on<AdminLoginEvent>((event, emit) {
      emit(LoadingState());
      emit(AdminLoginSuccessState());
    });

    on<SurveyorLoginEvent>((event, emit) {
      emit(LoadingState());
      emit(SurveyorLoginSuccessState());
    });
  }
}
