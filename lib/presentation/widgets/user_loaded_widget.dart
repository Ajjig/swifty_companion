import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swifty_companion/business_logic/cubit/user_cubit.dart';
import 'package:swifty_companion/core/theme.dart';
import 'package:swifty_companion/data/models/profile_model.dart';

class UserLoadedWidget extends StatelessWidget {
  final ProfileModel profile;

  const UserLoadedWidget({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => context.read<UserCubit>().logout(),
            tooltip: 'Logout',
            backgroundColor: Colors.white,
            child: const Icon(Icons.logout, color: Colors.redAccent),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'avatar',
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        profile.image['versions']['medium'] ??
                            profile.image['versions']['small'] ??
                            profile.image['link'] ??
                            'https://img.freepik.com/free-psd/3d-render-avatar-character_23-2150611765.jpg',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Hello,',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        profile.login,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.mainColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.arrow_forward,
                        color: Colors.white, size: 20),
                    label: const Text('Check your profile'),
                    onPressed: () => Navigator.of(context).pushNamed('/home'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppTheme.mainColor,
                      minimumSize: const Size(220, 40),
                      maximumSize: const Size(220, 40),
                    ),
                  ),
                  const SizedBox(height: 3),
                  ElevatedButton.icon(
                    icon: const Icon(
                      Icons.search,
                      color: AppTheme.mainColor,
                      size: 20,
                    ),
                    label: const Text('Search for profiles'),
                    onPressed: () =>
                        Navigator.of(context).pushReplacementNamed('/login'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppTheme.mainColor,
                      minimumSize: const Size(220, 40),
                      maximumSize: const Size(220, 40),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
