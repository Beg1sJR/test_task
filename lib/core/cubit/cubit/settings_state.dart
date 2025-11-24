part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final Brightness brightness;

  const SettingsState(this.brightness);

  SettingsState copyWith({Brightness? brightness}) {
    return SettingsState(brightness ?? this.brightness);
  }

  @override
  List<Object> get props => [brightness];
}
