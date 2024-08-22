import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/profile_bloc.dart';

class AllProfilePage extends StatelessWidget {
  const AllProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All User Page'),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        bloc: context.read<ProfileBloc>()..add(ProfileGetAllUser(2)),
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProfileError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is ProfileLoadedAllUser) {
            return ListView.builder(
              itemCount: state.allUser.length,
              itemBuilder: (context, index) {
                final user = state.allUser[index];
                return ListTile(
                  onTap: () {
                    context.pushNamed(
                      'detail_user',
                      extra: user.id,
                    );
                  },
                  title: Text(' ${user.firstName + user.lastName}'),
                  subtitle: Text(' ${user.email}'),
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
    );
  }
}
