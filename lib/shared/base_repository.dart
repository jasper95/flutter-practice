import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:todo_practice/services/api.dart';
import 'package:todo_practice/shared/base_entity.dart';
import 'package:todo_practice/services/file_helper.dart';
import 'package:todo_practice/services/connectivity.dart';

import 'package:todo_practice/locator.dart';

abstract class BaseRepository<T extends BaseEntity,
    Adapter extends TypeAdapter<T>> {
  BaseRepository({this.key, this.adapter, this.listRoute});

  final String key;
  final String listRoute;
  final Adapter adapter;
  final Dio dioClient = Dio(BaseOptions(
      // connectTimeout: 5000,
      // receiveTimeout: 5000,
      // headers: {HttpHeaders.userAgentHeader: 'dio'},
      ));

  final _fileHelper = locator<FileHelper>();
  final _hiveService = locator<HiveInterface>();
  final _client = locator<ApiService>().client;
  final _connectivityService = locator<ConnectivityService>();

  bool get _isBoxOpen => _hiveService.isBoxOpen(key);
  Box<T> get _box => _hiveService.box<T>(key);

  T fromJson(Map<String, dynamic> data);

  init() async {
    final path = await _fileHelper.getApplicationDocumentsDirectoryPath();
    _hiveService.init(path);
    _hiveService.registerAdapter<T>(adapter);

    if (!_isBoxOpen) {
      await _hiveService.openBox<T>(key);
    }
  }

  Future<List<T>> fetch() async {
    return fetchRemote();
    if (await _connectivityService.isConnected) {
      final records = await fetchRemote();
      cache(records);
      return records;
    } else {
      return fetchLocal();
    }
  }

  Future<List<T>> fetchRemote() async {
    try {
      Response<List<dynamic>> response = await _client.get(listRoute);
      return response.data.map((e) => fromJson(e)).toList();
    } catch (err) {}
    return [];
  }

  List<T> fetchLocal() {
    if (_box.isEmpty) {
      // throw CacheEx('No posts found in cache');
    }

    return _box.values.toList();
  }

  cache(List<T> records) async {
    final map = <String, T>{};
    records.forEach((record) => map.addAll({record.id: record}));
    await _box.putAll(map);
  }
}
