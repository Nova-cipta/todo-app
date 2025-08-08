import 'package:dartz/dartz.dart';
import 'package:todo_app/core/domain/entity/todo.dart';
import 'package:todo_app/core/domain/repository/todo_repository.dart';
import 'package:todo_app/core/error/failure.dart';

abstract class GetTodoList<Type> {
  Future<Either<Failure, List<Todo>>> call({required String name});
}

class GetTodoListImpl implements GetTodoList<List<Todo>> {
  final TodoRepository repository;

  GetTodoListImpl({required this.repository});

  @override
  Future<Either<Failure, List<Todo>>> call({required String name}) async {
    return await repository.getTodoList(name: name);
  }
}