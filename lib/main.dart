import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/core/cubit/cubit/settings_cubit.dart';
import 'package:test_task/core/router/router.dart';
import 'package:test_task/core/theme/theme.dart';
import 'package:test_task/features/auth/presentation/logic/bloc/auth_bloc.dart';
import 'package:test_task/features/products/presentation/logic/bloc/products_bloc.dart';
import 'package:test_task/features/profile/presentation/logic/bloc/profile_bloc.dart';
import 'package:test_task/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final routerRepository = getIt<AppRouter>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthBloc>()),
        BlocProvider(create: (context) => getIt<ProfileBloc>()),
        BlocProvider(create: (context) => getIt<ProductsBloc>()),

        BlocProvider(create: (context) => getIt<SettingsCubit>()),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: state.brightness == Brightness.dark ? darkTheme : lightTheme,
            routerConfig: routerRepository.router,
          );
        },
      ),
    );
  }
}
