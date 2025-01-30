import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swifty_companion/business_logic/cubit/user_cubit.dart';
import 'package:swifty_companion/data/models/profile_model.dart';
import 'package:swifty_companion/data/providers/api_provider.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit._privateConstructor() : super(ProfileInitial());

  static final ProfileCubit _instance = ProfileCubit._privateConstructor();

  factory ProfileCubit() {
    return _instance;
  }

  void getProfile(String login) async {
    emit(ProfileLoading());
    try {
      final Response<dynamic> profile = await ApiProvider.getProfileInfo(login);
      emit(ProfileLoaded(ProfileModel.fromJson(profile.data)));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  void me() async {
    try {
      emit(ProfileLoading());
      if (UserCubit().state is UserLoaded) {
        final UserLoaded user = UserCubit().state as UserLoaded;
        emit(ProfileLoaded(user.profile));
      } else {
        final Response<dynamic> profile = await ApiProvider.getCurrentUser();
        emit(ProfileLoaded(ProfileModel.fromJson(profile.data)));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
