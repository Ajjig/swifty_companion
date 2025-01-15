import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:swifty_companion/data/models/profile_model.dart';
import 'package:swifty_companion/data/providers/api_provider.dart';
import 'package:swifty_companion/data/providers/auth_api_provider.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit._privateConstructor() : super(UserInitial());

  static final UserCubit _instance = UserCubit._privateConstructor();

  factory UserCubit() {
    return _instance;
  }

  void login() {
    AuthApiProvider.login();
  }

  void loggedIn(ProfileModel profile) {
    emit(UserLoaded(profile));
  }

  void browserClosed() {
    emit(UserInitial());
  }

  void logout() {
    emit(UserInitial());
  }

  void getCurrentUser() async {
    emit(UserLoading());
    try {
      final profile = await ApiProvider.getCurrentUser();
      emit(UserLoaded(ProfileModel.fromJson(profile.data)));
    } catch (e) {
      emit(
        UserError(
            e.toString().length > 100 ? 'An error occurred' : e.toString()),
      );
    }
  }
}
