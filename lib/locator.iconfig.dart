// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:todo_practice/services/api.dart';
import 'package:todo_practice/services/authentication.dart';
import 'package:todo_practice/services/connectivity.dart';
import 'package:todo_practice/services/third_party_services.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo_practice/services/file_helper.dart';
import 'package:hive/hive.dart';
import 'package:todo_practice/services/todo_list.dart';
import 'package:todo_practice/repositories/todo.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  g.registerLazySingleton<ApiService>(() => ApiService());
  g.registerLazySingleton<AuthenticationService>(() => AuthenticationService());
  g.registerLazySingleton<ConnectivityService>(() => ConnectivityService());
  g.registerLazySingleton<DialogService>(
      () => thirdPartyServicesModule.dialogService);
  g.registerLazySingleton<FileHelper>(() => FileHelper());
  g.registerLazySingleton<HiveInterface>(
      () => thirdPartyServicesModule.hiveInterface);
  g.registerLazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  g.registerLazySingleton<TodoListService>(() => TodoListService());
  g.registerLazySingleton<TodoRepository>(() => TodoRepository());
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigationService => NavigationService();
}
