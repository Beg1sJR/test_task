import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_task/features/auth/presentation/logic/bloc/auth_bloc.dart';
import 'package:test_task/features/auth/presentation/logic/bloc/auth_event.dart';
import 'package:test_task/features/auth/presentation/logic/bloc/auth_state.dart';
import 'package:test_task/features/auth/presentation/pages/login/login.dart';

class LoginLauncherPage extends StatefulWidget {
  const LoginLauncherPage({super.key});

  @override
  State<LoginLauncherPage> createState() => _LoginLauncherPageState();
}

class _LoginLauncherPageState extends State<LoginLauncherPage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(CheckToken());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is TokenLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TokenAuthenticated) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              log('GOING HOME PAGE');
              context.go('/home');
            });
            return const SizedBox();
          } else if (state is TokenNotAuthenticated) {
            return const LoginPage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
