part of 'splash_bloc.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();
}

class FetchUserInfoEvent extends SplashEvent {
  @override
  List<Object?> get props => [];
}
