import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/blocs/user/user_bloc.dart';
import '../../core/constants/color.dart';
import '../../core/models/user.dart';
import '../../core/providers/user_repository.dart';

class MainProfilePage extends StatelessWidget {
  const MainProfilePage({super.key});
  static const routeName = '/profilePage';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(
        RepositoryProvider.of<UserRepository>(context),
      )..add(LoadUser()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Profile", style: Constant.size14c476),
          backgroundColor: white,
          elevation: 2,
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            debugPrint('-----BlocListener state: ${state.runtimeType}');
            if (state is LodingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserLoadedState) {
              debugPrint('UserLoadedState : ${state.user.toString()}');

              return _buildProfileContent(state.user);
            } else if (state is ErrorState) {
              return Center(
                  child: Text('Error loading profile: ${state.error}'));
            } else {
              return const SizedBox.shrink(); // Handle other states if needed
            }
          },
        ),
      ),
    );
  }

  Widget _buildProfileContent(UserM user) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          user.imageUrl != null
              ? Center(
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: user.imageUrl!,
                    height: 80.0,
                    width: 80.0,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                )
              : Center(
                  child: Icon(
                    Icons.picture_in_picture,
                    size: 80,
                  ),
                ),
          /* Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: 
                                user.imageUrl!,
                            height: 80.0,
                            width: 80.0,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          )
                        : Image.asset(
                            'assets/empty_image.png',
                            fit: BoxFit.cover,
                            width: 80,
                            height: 80,
                          ),
            ),
          ),*/
          const SizedBox(height: 20),
          Text(
            user.name!,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(user.email!),
          // const SizedBox(height: 20),
          // Add more profile details here (e.g., bio, location, etc.)
          // const Text('Bio:', style: TextStyle(fontWeight: FontWeight.bold)),
          // Text(user.bio ?? 'No bio provided.'),
          const SizedBox(height: 20),
          // Add settings or edit profile options
          ElevatedButton(
            onPressed: () {
              // Navigate to edit profile screen
              // Navigator.pushNamed(context, '/editProfile');
            },
            child: const Text('Edit Profile'),
          ),
        ],
      ),
    );
  }
}
