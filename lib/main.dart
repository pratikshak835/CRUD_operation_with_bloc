import 'package:crud_operation_using_bloc/crud_opration/bloc/crud_opration_bloc.dart';
import 'package:crud_operation_using_bloc/crud_opration/view/crud_opration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: BlocProvider(
      create: (context) => UserListBloc(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CrudOperationScreen(),
      ),
    ));
  }
}
