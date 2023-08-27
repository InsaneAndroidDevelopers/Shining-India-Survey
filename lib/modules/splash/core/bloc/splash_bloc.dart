import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shining_india_survey/helpers/shared_pref_helper.dart';
import 'package:shining_india_survey/utils/string_constants.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<FetchUserInfoEvent>((event, emit) async {
      await Future.delayed(const Duration(seconds: 3), () {});
      String token = await SharedPreferencesHelper.getUserToken();
      if(token.isEmpty){
        emit(NavigateToLoginScreen());
        return;
      }
      String userRole = await SharedPreferencesHelper.getUserRole();
      if(userRole == StringsConstants.USER_ADMIN) {
        emit(NavigateToAdminHomeScreen());
      }else if(userRole == StringsConstants.USER_SURVEYOR) {
        emit(NavigateToSurveyorHomeScreen());
      }
    });
  }
}
