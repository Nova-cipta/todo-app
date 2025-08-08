import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final int id;
  final String title;
  final String assignedTo;
  final bool isDone;
  final String date;

  const Todo({
    required this.id,
    required this.title,
    required this.assignedTo,
    required this.isDone,
    required this.date
  });

  factory Todo.fromMap({required Map<String, dynamic> data}) => Todo(
    id: data["id"],
    title: data["title"],
    assignedTo: data["assigned_to"],
    isDone: data["is_done"] == 1,
    date: data["date"]
  );

  Map<String, dynamic> get toMap => {
    "title" : title,
    "assigned_to" : assignedTo,
    "is_done" : isDone ? 1 : 0,
    "date" : date
  };

  @override
  List<Object?> get props => [id, title, isDone, date];
}