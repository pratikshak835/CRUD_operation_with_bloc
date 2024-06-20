import 'package:crud_operation_using_bloc/crud_opration/bloc/crud_opration_bloc.dart';
import 'package:crud_operation_using_bloc/crud_opration/bloc/crud_opration_events.dart';
import 'package:crud_operation_using_bloc/crud_opration/bloc/crud_opration_state.dart';
import 'package:crud_operation_using_bloc/crud_opration/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CrudOperationScreen extends StatelessWidget {
  const CrudOperationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD Operation'),
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          final state = context.read<UserListBloc>().state;
          final id = state.users.length + 1;
          showBottomSheet(
            context: context,
            id: id,
            nameController: TextEditingController(),
            emailController: TextEditingController(),
          );
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
        child: const Text(
          'Add User',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: BlocBuilder<UserListBloc, UserListState>(
        builder: (context, state) {
          if (state is UserListUpdatedState && state.users.isNotEmpty) {
            final users = state.users;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Column(
                  children: [
                    buildUserTile(context, user),
                    const Divider(
                      height: 1,
                      color: Colors.grey,
                    )
                  ],
                );
              },
            );
          } else {
            return const SizedBox(
              width: double.infinity,
              child: Center(
                child: Text(
                  'No User Found',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildUserTile(BuildContext context, User user) {
    return ListTile(
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              context.read<UserListBloc>().add(DeleteUserEvent(user: user));
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              final nameController =
                  TextEditingController(text: user.name.trim());
              final emailController =
                  TextEditingController(text: user.email.trim());
              showBottomSheet(
                context: context,
                id: user.id,
                isEdit: true,
                nameController: nameController,
                emailController: emailController,
              );
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.green,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}

void showBottomSheet({
  required BuildContext context,
  required int id,
  bool isEdit = false,
  required TextEditingController nameController,
  required TextEditingController emailController,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          right: 20,
          left: 20,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: 'Enter Name'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(hintText: 'Enter Email'),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () {
                  final user = User(
                    name: nameController.text,
                    email: emailController.text,
                    id: id,
                  );
                  if (isEdit) {
                    context
                        .read<UserListBloc>()
                        .add(UpdateUserEvent(user: user));
                  } else {
                    context.read<UserListBloc>().add(AddUserEvent(user: user));
                  }
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: Text(
                  isEdit ? 'Update User' : 'Add User',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
