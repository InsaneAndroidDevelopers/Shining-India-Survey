part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoadingState extends LoginState {
  @override
  List<Object> get props => [];
}

class ErrorState extends LoginState {
  @override
  List<Object> get props => [];
}

class AdminLoginSuccessState extends LoginState {
  @override
  List<Object> get props => [];
}

class SurveyorLoginSuccessState extends LoginState {
  @override
  List<Object> get props => [];
}