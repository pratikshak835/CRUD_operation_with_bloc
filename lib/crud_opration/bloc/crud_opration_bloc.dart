import 'package:crud_operation_using_bloc/crud_opration/bloc/crud_opration_events.dart';
import 'package:crud_operation_using_bloc/crud_opration/bloc/crud_opration_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  UserListBloc() : super(UserListInitialState(users: [])) {
    on<AddUserEvent>(_addUser);
    on<UpdateUserEvent>(_updateUser);
    on<DeleteUserEvent>(_deleteUser);
  }

  void _addUser(AddUserEvent event, Emitter<UserListState> emit) {
    state.users.add(event.user);
    emit(UserListUpdatedState(users: state.users));
  }

  void _deleteUser(DeleteUserEvent event, Emitter<UserListState> emit) {
    state.users.remove(event.user);
    emit(UserListUpdatedState(users: state.users));
  }

  void _updateUser(UpdateUserEvent event, Emitter<UserListState> emit) {
    for (int i = 0; i < state.users.length; i++) {
      if (event.user.id == state.users[i].id) {
        state.users[i] = event.user;
      }
    }
    emit(UserListUpdatedState(users: state.users));
  }
}
