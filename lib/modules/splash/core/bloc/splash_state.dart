part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  const SplashState();
}

class SplashInitial extends SplashState {
  @override
  List<Object> get props => [];
}

class NavigateToAdminHomeScreen extends SplashState {
  @override
  List<Object?> get props => [];
}

class NavigateToSurveyorHomeScreen extends SplashState {
  @override
  List<Object?> get props => [];
}

class NavigateToLoginScreen extends SplashState {
  @override
  List<Object?> get props => [];
}
