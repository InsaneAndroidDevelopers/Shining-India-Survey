part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class AdminLoginEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class SurveyorLoginEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}
