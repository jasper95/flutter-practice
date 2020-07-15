import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ApiService {
  final Dio _client = Dio(BaseOptions(
    baseUrl: "https://jsonplaceholder.typicode.com",
    connectTimeout: 5000,
    receiveTimeout: 5000,
    headers: {HttpHeaders.userAgentHeader: 'dio'},
  ))
    ..interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      // TODO: Add token
      return options;
    }, onError: (DioError e) async {
      // final snackBar = SnackBar(content: Text('Network Error'));
      // Scaffold.of(context).showSnackBar(snackBar);
      return e;
    }));

  Dio get client => _client;
}
