import 'package:flutter/material.dart';
import 'package:swifty_companion/core/theme.dart';
import 'package:swifty_companion/data/models/profile_model.dart';

class UserLoadedWidget extends StatelessWidget {
  final ProfileModel profile;

  const UserLoadedWidget({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  // Handle avatar click
                },
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
                label: const Text('Continue'),
                onPressed: () =>
                    Navigator.of(context).pushReplacementNamed('/home'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(150, 40),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
