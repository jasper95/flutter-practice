import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart' as Uuid;

abstract class BaseEntity<T> {
  @HiveField(0)
  @JsonKey(fromJson: stringFromInt)
  final String id;
  BaseEntity({String id}) : id = id ?? Uuid.Uuid().v4();

  T fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();

  static String stringFromInt(number) =>
      number is String ? number : number?.toString();
}
