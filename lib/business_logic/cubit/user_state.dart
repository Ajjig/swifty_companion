part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserLoaded extends UserState {
  final ProfileModel profile;

  UserLoaded(this.profile);
}

final class UserError extends UserState {
  final String message;

  UserError(this.message);
}
