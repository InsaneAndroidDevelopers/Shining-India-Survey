part of 'admin_home_bloc.dart';

abstract class AdminHomeEvent extends Equatable {
  const AdminHomeEvent();
}

class AdminLogout extends AdminHomeEvent {
  @override
  List<Object> get props => [];
}

class GetAdminInfo extends AdminHomeEvent {
  @override
  List<Object> get props => [];
}
