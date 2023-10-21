part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class AdminLoginEvent extends LoginEvent {
  final String email;
  final String password;
  const AdminLoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [];
}

class SurveyorLoginEvent extends LoginEvent {
  final String email;
  final String password;
  const SurveyorLoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [];
}
