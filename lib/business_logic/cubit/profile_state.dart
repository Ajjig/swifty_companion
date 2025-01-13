part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final ProfileModel profile;

  ProfileLoaded(this.profile);
}

final class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}

final class ProfileUnexpectedError extends ProfileState {}
