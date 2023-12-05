import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shining_india_survey/helpers/shared_pref_helper.dart';
import 'package:shining_india_survey/modules/admin_home/core/repository/admin_home_repository.dart';
import 'package:shining_india_survey/utils/exceptions.dart';

part 'admin_home_event.dart';
part 'admin_home_state.dart';

class AdminHomeBloc extends Bloc<AdminHomeEvent, AdminHomeState> {
  AdminHomeBloc() : super(AdminHomeInitial()) {

    final AdminHomeRepository adminHomeRepository = AdminHomeRepository();

    on<AdminLogout>((event, emit) async {
      emit(AdminHomeLogoutLoading());
      try{
        final bool isLoggedOut = await adminHomeRepository.adminLogout();
        if(isLoggedOut) {
          await SharedPreferencesHelper.clearAll();
          emit(AdminHomeLogoutSuccess());
        }
      } on AppExceptionDio catch(e) {
        emit(AdminHomeLogoutError(message: e.message));
      } on DioException catch(e) {
        emit(AdminHomeLogoutError(message: 'Something went wrong'));
      } catch(e) {
        emit(AdminHomeLogoutError(message: e.toString()));
      }
    });

    on<GetAdminInfo>((event, emit) async {
      final name = await SharedPreferencesHelper.getUserName();
      emit(AdminHomeInfoFetchedState(name: name));
    });
  }
}
