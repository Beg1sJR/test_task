import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_task/core/responsive/responsive.dart';
import 'package:test_task/features/auth/presentation/logic/bloc/auth_bloc.dart';
import 'package:test_task/features/auth/presentation/logic/bloc/auth_event.dart';
import 'package:test_task/features/auth/presentation/logic/bloc/auth_state.dart';
import 'package:test_task/features/profile/presentation/logic/bloc/profile_bloc.dart';
import 'package:test_task/features/profile/presentation/widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(LoadProfileData());
  }

  @override
  Widget build(BuildContext context) {
    double paddingNum;
    if (Responsive.isTablet(context)) {
      paddingNum = 200.0;
    } else if (Responsive.isDesktop(context)) {
      paddingNum = 300.0;
    } else {
      paddingNum = 0;
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Профиль'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is TokenNotAuthenticated || state is AuthInitial) {
              context.go('/login');
            }
          },
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProfileLoaded) {
                final user = state.user;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    CircleAvatar(
                      radius: 40,
                      child: Icon(Icons.person, size: 40),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          user.lastName ?? '',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 15),
                        Text(
                          user.firstName ?? 'Имя не указано',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    Text(
                      user.email ?? 'Email не указан',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: paddingNum),
                      child: Column(
                        children: [
                          ProfileTile(
                            icon: Icons.edit,
                            title: 'Редактировать данные',
                            onTap: () {},
                          ),
                          ProfileTile(
                            icon: Icons.settings_outlined,
                            title: 'Настройки',
                            onTap: () {
                              context.push('/profile/settings');
                            },
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text('Выход'),
                                  content: const Text(
                                    'Вы действительно хотите выйти?',
                                  ),
                                  actions: [
                                    TextButton(
                                      child: const Text('Отмена'),
                                      onPressed: () => context.pop(),
                                    ),
                                    TextButton(
                                      child: const Text(
                                        'Выйти',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      onPressed: () {
                                        context.pop();
                                        context.read<AuthBloc>().add(
                                          LogoutEvent(),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                color: Colors.red.shade600,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Center(
                                child: Text(
                                  'Выйти',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                );
              } else {
                return const Center(child: Text('Что-то пошло не так'));
              }
            },
          ),
        ),
      ),
    );
  }
}
