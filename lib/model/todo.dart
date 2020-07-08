import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart' as Uuid;

part 'todo.g.dart';

@JsonSerializable()
class Todo {
  final String title;
  final String description;
  final bool isCompleted;
  final String id;

  @override
  String toString() {
    return 'Todo{isCompleted: $isCompleted, title: $title, description: $description, id: $id}';
  }

  Todo({this.title, this.description, this.isCompleted = false, String id})
      : id = id ?? Uuid.Uuid().v4();
  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
  Map<String, dynamic> toJson() => _$TodoToJson(this);
  Todo copy({String title, bool isCompleted, String description, String id}) {
    return Todo(
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      description: description ?? this.description,
      id: id ?? this.id,
    );
  }
}
