import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_bloc/features/user/presentation/bloc/user_add/user_add_bloc.dart';
import 'package:flutter_clean_architecture_bloc/features/user/presentation/bloc/user_delete/user_delete_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/user_get/user_get_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text('Data User'),
      ),
      body: BlocListener<UserAddBloc, UserAddState>(
        listener: (context, state) {
          context.read<UserGetBloc>().add(GetUserListEvent());
        },
        child: BlocListener<UserDeleteBloc, UserDeleteState>(
          listener: (context, state) {
            context.read<UserGetBloc>().add(GetUserListEvent());
          },
          child: BlocBuilder<UserGetBloc, UserGetState>(
            bloc: context.read<UserGetBloc>()..add(GetUserListEvent()),
            builder: (context, state) {
              if (state is UserGetLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is UserGetError) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state is UserGetLoaded) {
                return ListView.builder(
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    final user = state.users[index];
                    return ListTile(
                      onTap: () {
                        context.pushNamed(
                          'detail_user',
                          extra: user.id,
                        );
                      },
                      onLongPress: () {
                        showDeleteUserDialog(context, user.id);
                      },
                      title: Text(user.name),
                      subtitle: Text(user.email),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text('EMPTY USERS'),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddUserDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void showAddUserDialog(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController addressController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add User'),
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
            TextButton(
              onPressed: () {
                context.read<UserAddBloc>().add(AddUserEvent(
                      nameController.text,
                      emailController.text,
                      addressController.text,
                    ));
                context.pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void showDeleteUserDialog(BuildContext context, String userId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this user?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                context.read<UserDeleteBloc>().add(DeleteUserEvent(userId));
                context.pop();
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
