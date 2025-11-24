import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_settings.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:test_task/core/cubit/cubit/settings_cubit.dart';
import 'package:test_task/core/router/router.dart';
import 'package:test_task/features/auth/data/data_source/auth.dart';
import 'package:test_task/features/auth/data/data_source/profile_local_data_source/profile_local_data_source.dart';
import 'package:test_task/features/auth/data/repository/login.dart';
import 'package:test_task/features/auth/domain/repository/login.dart';
import 'package:test_task/features/auth/presentation/logic/bloc/auth_bloc.dart';
import 'package:test_task/features/products/data/data_source/products.dart';
import 'package:test_task/features/products/data/repository/products.dart';
import 'package:test_task/features/products/domain/repository/products.dart';
import 'package:test_task/features/products/presentation/logic/bloc/products_bloc.dart';
import 'package:test_task/features/profile/data/repository/profile/profile.dart';
import 'package:test_task/features/profile/data/repository/settings/settings.dart';
import 'package:test_task/features/profile/domain/repository/profile/profile.dart';
import 'package:test_task/features/profile/domain/repository/settings/settings.dart';
import 'package:test_task/features/profile/presentation/logic/bloc/profile_bloc.dart';
import 'package:test_task/services/secure_storage/secure_storage_impl.dart';
import 'package:test_task/services/secure_storage/secure_storage_repository.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  final talker = TalkerFlutter.init();
  final dio = Dio();
  final sharedPreferences = await SharedPreferences.getInstance();
  final secureStorage = FlutterSecureStorage();

  talker.verbose('Talker initialized');
  getIt.registerSingleton<Talker>(talker);
  getIt.registerSingleton<Dio>(dio);

  Bloc.observer = TalkerBlocObserver(
    talker: getIt<Talker>(),
    settings: const TalkerBlocLoggerSettings(
      printEventFullData: false,
      printStateFullData: false,
      printCreations: false,
      printClosings: false,
      printTransitions: false,
      printChanges: true,
    ),
  );
  log('bloc talker launched');

  dio.interceptors.add(
    TalkerDioLogger(
      talker: getIt<Talker>(),
      settings: const TalkerDioLoggerSettings(
        printRequestData: true,
        printRequestHeaders: false,
        printResponseData: true,
        printResponseHeaders: false,
      ),
    ),
  );
  log('dio talker launched');

  //router
  getIt.registerSingleton<AppRouter>(AppRouter());
  log('AppRouter registered');

  //shared preferences
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);
  log('shared preferences registered');

  //secure storage
  getIt.registerLazySingleton<FlutterSecureStorage>(() => secureStorage);
  log('secure storage registered');

  //data
  getIt.registerLazySingleton<AuthData>(() => AuthData(dio: getIt<Dio>()));

  getIt.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSource(sharedPreferences: getIt<SharedPreferences>()),
  );

  getIt.registerLazySingleton<ProductsData>(
    () => ProductsData(dio: getIt<Dio>()),
  );

  //repository
  getIt.registerSingleton<SettingsRepository>(
    SettingsRepositoryImpl(sharedPreferences: getIt<SharedPreferences>()),
  );
  log('settings repo registered');

  getIt.registerLazySingleton<SecureStorageRepository>(
    () => SecureStorageImpl(secureStorage: getIt<FlutterSecureStorage>()),
  );
  log('secure storage repo registered');

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authData: getIt<AuthData>()),
  );

  log('auth repo registered');

  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(local: getIt<ProfileLocalDataSource>()),
  );

  log('profile repo registered');

  getIt.registerLazySingleton<ProductsRepository>(
    () => ProductsRepositoryImpl(productsData: getIt<ProductsData>()),
  );

  log('products repo registered');

  //blocs
  getIt.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      profileRepository: getIt<ProfileRepository>(),
      authRepository: getIt<AuthRepository>(),
      secureStorageRepository: getIt<SecureStorageRepository>(),
    ),
  );
  log('news bloc registered');

  getIt.registerLazySingleton<ProfileBloc>(
    () => ProfileBloc(repository: getIt<ProfileRepository>()),
  );
  log('news bloc registered');

  getIt.registerLazySingleton<ProductsBloc>(
    () => ProductsBloc(
      productsRepository: getIt<ProductsRepository>(),
      secureStorageRepository: getIt<SecureStorageRepository>(),
    ),
  );
  log('products bloc registered');

  //cubit
  getIt.registerSingleton<SettingsCubit>(
    SettingsCubit(getIt<SettingsRepository>()),
  );
  log('settings cubit registered');
}
