part of 'admin_home_bloc.dart';

abstract class AdminHomeState extends Equatable {
  const AdminHomeState();
}

class AdminHomeInitial extends AdminHomeState {
  @override
  List<Object> get props => [];
}

class AdminHomeLogoutLoading extends AdminHomeState {
  @override
  List<Object> get props => [];
}

class AdminHomeLogoutError extends AdminHomeState {
  final String message;
  const AdminHomeLogoutError({required this.message});

  @override
  List<Object> get props => [];
}

class AdminHomeLogoutSuccess extends AdminHomeState {
  @override
  List<Object> get props => [];
}

class AdminHomeInfoFetchedState extends AdminHomeState {
  final String name;
  const AdminHomeInfoFetchedState({required this.name});

  @override
  List<Object> get props => [];
}
