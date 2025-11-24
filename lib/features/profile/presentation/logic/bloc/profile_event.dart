part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

final class LoadProfileData extends ProfileEvent {}

class UpdateProfileData extends ProfileEvent {
  final String firstName;
  final String lastName;

  const UpdateProfileData({required this.firstName, required this.lastName});

  @override
  List<Object> get props => [firstName, lastName];
}
