import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/features/auth/data/model/login/login.dart';
import 'package:test_task/features/profile/domain/repository/profile/profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;

  ProfileBloc({required this.repository}) : super(ProfileInitial()) {
    on<LoadProfileData>(_onLoadProfileData);
  }

  FutureOr<void> _onLoadProfileData(event, emit) async {
    emit(ProfileLoading());
    try {
      final user = await repository.getUser();

      emit(ProfileLoaded(user: user));
    } catch (e) {
      emit(ProfileError('Профиль не найден'));
    }
  }
}
