import 'package:crud_operation_using_bloc/crud_opration/model/user_model.dart';

abstract class UserListEvent {}

class AddUserEvent extends UserListEvent {
  AddUserEvent({required this.user});

  final User user;
}

class DeleteUserEvent extends UserListEvent {
  DeleteUserEvent({required this.user});

  final User user;
}

class UpdateUserEvent extends UserListEvent {
  UpdateUserEvent({required this.user});

  final User user;
}
