import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_bloc/features/user/presentation/bloc/user_edit/user_edit_bloc.dart';
import 'package:flutter_clean_architecture_bloc/features/user/presentation/bloc/user_get/user_get_bloc.dart';
import 'package:flutter_clean_architecture_bloc/injection.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/user.dart';
import '../bloc/user_detail/user_detail_bloc.dart';

class DetailUserPage extends StatelessWidget {
  final String userId;
  const DetailUserPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail User'),
      ),
      body: BlocBuilder<UserDetailBloc, UserDetailState>(
        bloc: context.read<UserDetailBloc>()..add(GetUserDetailEvent(userId)),
        builder: (context, state) {
          if (state is UserDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UserDetailError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is UserDetailLoaded) {
            final user = state.user;
            return Card(
              margin: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Name : ${user.name}'),
                    Text('Email : ${user.email}'),
                    Text('Address : ${user.address}'),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Tampilkan dialog untuk mengedit user
                        showEditUserDialog(context, user);
                      },
                      child: const Text('Edit'),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: Text('EMPTY USER'),
            );
          }
        },
      ),
    );
  }

  void showEditUserDialog(BuildContext context, User user) {
    final TextEditingController emailController = TextEditingController(text: user.email);
    final TextEditingController nameController = TextEditingController(text: user.name);
    final TextEditingController addressController = TextEditingController(text: user.address);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit User'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(labelText: 'Address'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Cancel'),
            ),
            BlocListener<UserEditBloc, UserEditState>(
              listener: (context, state) {
                if (state is UserEditLoaded) {
                  context.read<UserDetailBloc>().add(GetUserDetailEvent(userId));
                  context.read<UserGetBloc>().add(GetUserListEvent());
                  context.pop();
                }
              },
              child: TextButton(
                onPressed: () {
                  context.read<UserEditBloc>().add(EditUserEvent(
                        user.id,
                        nameController.text,
                        emailController.text,
                        addressController.text,
                      ));
                },
                child: const Text('Save'),
              ),
            ),
          ],
        );
      },
    );
  }
}
