import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:todo_practice/shared/base_entity.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class Todo extends BaseEntity {
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  @JsonKey(name: 'completed')
  final bool isCompleted;

  @override
  String toString() {
    return 'Todo{isCompleted: $isCompleted, title: $title, description: $description, id: $id}';
  }

  Todo(
      {this.title = '',
      this.description = '',
      this.isCompleted = false,
      String id})
      : super(id: id);

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TodoToJson(this);
  @override
  Todo fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  Todo copy({String title, bool isCompleted, String description, String id}) {
    return Todo(
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      description: description ?? this.description,
      id: id ?? this.id,
    );
  }
}
