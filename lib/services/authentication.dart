import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_practice/locator.dart';
import 'package:todo_practice/services/api.dart';

enum AuthStatus { Unitialized, Authenticating, Unauthenticated, Authenticated }

@lazySingleton
class AuthenticationService {
  final Dio api = locator<ApiService>().client;
  login(Map<String, dynamic> data) async {}

  logout() async {}
}
