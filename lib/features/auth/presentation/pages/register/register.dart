import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_task/core/responsive/responsive.dart';
import 'package:test_task/features/auth/presentation/logic/bloc/auth_bloc.dart';
import 'package:test_task/features/auth/presentation/logic/bloc/auth_event.dart';
import 'package:test_task/features/auth/presentation/logic/bloc/auth_state.dart';
import 'package:test_task/features/auth/presentation/widgets/register/last_name_text_field.dart';
import 'package:test_task/features/auth/presentation/widgets/widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool isError = false;
  String errorMessage = '';

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
      backgroundColor: theme.scaffoldBackgroundColor,

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingNum),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 150),

              const Text(
                'Создать аккаунт',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w300),
              ),
              const SizedBox(height: 8),
              const Text(
                'Заполните форму для регистрации',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 40),

              NameTextField(nameController: _firstNameController),
              const SizedBox(height: 16),
              LastNameTextField(lastNameController: _lastNameController),
              const SizedBox(height: 16),

              EmailTextFiled(emailController: _emailController),
              const SizedBox(height: 16),

              RegisterPasswordTextField(
                passwordController: _passwordController,
                obscurePassword: _obscurePassword,
                label: 'Пароль',
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              const SizedBox(height: 16),

              RegisterPasswordTextField(
                passwordController: _confirmPasswordController,
                obscurePassword: _obscureConfirmPassword,
                label: 'Подтвердите пароль',
                onPressed: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
              ),
              const SizedBox(height: 20),

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
                                  setState(() {
                                    isError = false;
                                    errorMessage = '';
                                  });

                                  if (_passwordController.text !=
                                      _confirmPasswordController.text) {
                                    setState(() {
                                      isError = true;
                                      errorMessage = 'Пароли должный совподать';
                                    });
                                    return;
                                  }
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

                                  if (_passwordController.text.length < 6) {
                                    setState(() {
                                      isError = true;
                                      errorMessage =
                                          'Пароль должен быть не менее 6 символов';
                                    });
                                    return;
                                  }

                                  setState(() {
                                    isError = false;
                                    errorMessage = '';
                                  });

                                  context.read<AuthBloc>().add(
                                    RegisterEvent(
                                      username: _emailController.text.trim(),
                                      password: _passwordController.text.trim(),
                                      firstName: _firstNameController.text
                                          .trim(),
                                      lastName: _lastNameController.text.trim(),
                                    ),
                                  );

                                  log(_emailController.text);
                                  log(_passwordController.text);
                                  log(_firstNameController.text);
                                  log(_lastNameController.text);
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3498DB),
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
                                  'Зарегистрироваться',
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

              GoLogin(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
