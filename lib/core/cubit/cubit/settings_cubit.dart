import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/features/profile/domain/repository/settings/settings.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._settingsRepository)
    : super(const SettingsState(Brightness.light)) {
    checkTheme();
  }

  final SettingsRepository _settingsRepository;

  Future<void> setTheme(Brightness brightness) async {
    emit(state.copyWith(brightness: brightness));
    await _settingsRepository.setDarkMode(brightness == Brightness.dark);
  }

  void checkTheme() {
    final brightness = _settingsRepository.getDarkMode()
        ? Brightness.dark
        : Brightness.light;
    emit(state.copyWith(brightness: brightness));
  }
}
