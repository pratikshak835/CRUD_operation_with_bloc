import 'package:crud_operation_using_bloc/crud_opration/model/user_model.dart';

abstract class UserListState {
  UserListState({required this.users});
  final List<User> users;
}

class UserListInitialState extends UserListState {
  UserListInitialState({required super.users});
}

class UserListUpdatedState extends UserListState {
  UserListUpdatedState({required super.users});
}
