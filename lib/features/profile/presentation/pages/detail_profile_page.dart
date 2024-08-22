import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/profile_bloc.dart';

class DetailProfilePage extends StatelessWidget {
  final int userId;
  const DetailProfilePage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail User'),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        bloc: context.read<ProfileBloc>()..add(ProfileGetDetailUser(userId)),
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProfileError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is ProfileLoadedUser) {
            final user = state.detailUser;
            return Card(
              margin: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.avatar),
                      radius: 50,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text('ID : ${user.id}'),
                    Text('Email : ${user.email}'),
                    Text('Fullname : ${user.firstName + user.lastName}'),
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
}
