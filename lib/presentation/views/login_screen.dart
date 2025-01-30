import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swifty_companion/business_logic/cubit/user_cubit.dart';
import 'package:swifty_companion/core/theme.dart';
import 'package:swifty_companion/presentation/widgets/user_loaded_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      if (state is UserLoading) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state is UserLoaded) {
        return UserLoadedWidget(profile: state.profile);
      } else {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Welcome to Swifty Companion',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: AppTheme.secondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => context.read<UserCubit>().login(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.mainColor,
                    minimumSize: const Size(220, 40),
                    maximumSize: const Size(220, 40),
                  ),
                  child: const Text(
                    'Login with intra42',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    });
  }
}
