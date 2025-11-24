import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/core/cubit/cubit/settings_cubit.dart';
import 'package:test_task/core/responsive/responsive.dart';
import 'package:test_task/core/theme/theme.dart';
import 'package:test_task/features/profile/presentation/widgets/widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = context.watch<SettingsCubit>().state.brightness;
    double paddingNum;
    if (Responsive.isTablet(context)) {
      paddingNum = 100.0;
    } else if (Responsive.isDesktop(context)) {
      paddingNum = 200.0;
    } else {
      paddingNum = 0;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Настройки'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingNum),
          child: Column(
            children: [
              SettingsTile(
                icon: Icons.dark_mode_outlined,
                iconColor: Colors.purple,
                title: 'Темная тема',
                subtitle: 'темная тема',
                trailing: theme.isAndroid
                    ? Switch(
                        value: brightness == Brightness.dark,
                        activeColor: Color(0xFF3498DB),
                        onChanged: (bool value) {
                          _darkThemeSwitch(context, value);
                        },
                      )
                    : CupertinoSwitch(
                        value: brightness == Brightness.dark,
                        onChanged: (bool value) {
                          _darkThemeSwitch(context, value);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _darkThemeSwitch(BuildContext context, bool value) {
    context.read<SettingsCubit>().setTheme(
      value ? Brightness.dark : Brightness.light,
    );
  }
}
