import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_task/core/responsive/responsive.dart';
import 'package:test_task/features/auth/presentation/logic/bloc/auth_bloc.dart';
import 'package:test_task/features/auth/presentation/logic/bloc/auth_event.dart';
import 'package:test_task/features/auth/presentation/logic/bloc/auth_state.dart';
import 'package:test_task/features/auth/presentation/widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool isError = false;
  String errorMessage = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double paddingNum;
    if (Responsive.isTablet(context)) {
      paddingNum = 100.0;
    } else if (Responsive.isDesktop(context)) {
      paddingNum = 200.0;
    } else {
      paddingNum = 24.0;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingNum),
          child: Column(
            children: [
              const Spacer(),
              const Text(
                'Добро пожаловать',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w300),
              ),
              const SizedBox(height: 8),
              const Text(
                'Войдите в свой аккаунт',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 48),

              EmailTextField(controller: _emailController),
              const SizedBox(height: 16),

              PasswordTextField(
                controller: _passwordController,
                obscurePassword: _obscurePassword,
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              const SizedBox(height: 24),

              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    context.go('/home');
                  } else if (state is AuthFailure) {
                    setState(() {
                      isError = true;
                      errorMessage = state.message;
                    });
                    log(errorMessage);
                  }
                },
                builder: (context, state) {
                  final isLoading = state is AuthLoading;

                  return Column(
                    children: [
                      if (isError) ErrorContainer(errorMessage: errorMessage),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  FocusScope.of(context).unfocus();
                                  setState(() {
                                    isError = false;
                                    errorMessage = '';
                                  });

                                  if (_emailController.text.isEmpty ||
                                      !EmailValidator.validate(
                                        _emailController.text.trim(),
                                      )) {
                                    setState(() {
                                      isError = true;
                                      errorMessage = 'Введите почту правильно';
                                    });
                                    return;
                                  }
                                  setState(() {
                                    isError = false;
                                    errorMessage = '';
                                  });
                                  context.read<AuthBloc>().add(
                                    LoginEvent(
                                      username: _emailController.text.trim(),
                                      password: _passwordController.text.trim(),
                                    ),
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF3498DB),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  'Войти',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 24),
              const CustomDivider(),
              const SizedBox(height: 24),
              const GoRegister(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
