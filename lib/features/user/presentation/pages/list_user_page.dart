import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_bloc/features/user/presentation/bloc/user_add/user_add_bloc.dart';
import 'package:flutter_clean_architecture_bloc/features/user/presentation/bloc/user_delete/user_delete_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/user_get/user_get_bloc.dart';

class ListUserPage extends StatelessWidget {
  const ListUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'List Data User',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: BlocBuilder<UserGetBloc, UserGetState>(
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
            return ListView.separated(
              itemCount: state.users.length,
              padding: const EdgeInsets.all(16),
              separatorBuilder: (context, index) => const SizedBox(height: 16.0),
              itemBuilder: (context, index) {
                final user = state.users[index];
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  child: ListTile(
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
                  ),
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
            BlocListener<UserAddBloc, UserAddState>(
              listener: (context, state) {
                if (state is UserAddLoaded) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Add User Success'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  context.read<UserGetBloc>().add(GetUserListEvent());
                  context.pop();
                }
              },
              child: TextButton(
                onPressed: () {
                  context.read<UserAddBloc>().add(AddUserEvent(
                        nameController.text,
                        emailController.text,
                        addressController.text,
                      ));
                },
                child: const Text('Add'),
              ),
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
            BlocListener<UserDeleteBloc, UserDeleteState>(
              listener: (context, state) {
                if (state is UserDeleteLoaded) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Delete User Success'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  context.read<UserGetBloc>().add(GetUserListEvent());
                  context.pop();
                }
              },
              child: TextButton(
                onPressed: () {
                  context.read<UserDeleteBloc>().add(DeleteUserEvent(userId));
                },
                child: const Text('Yes'),
              ),
            ),
          ],
        );
      },
    );
  }
}
