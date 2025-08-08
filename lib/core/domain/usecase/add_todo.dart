import 'package:dartz/dartz.dart';
import 'package:todo_app/core/domain/entity/todo.dart';
import 'package:todo_app/core/domain/repository/todo_repository.dart';
import 'package:todo_app/core/error/failure.dart';

abstract class AddTodo<Type> {
  Future<Either<Failure, bool>> call({required Todo data});
}

class AddTodoImpl implements AddTodo<bool> {
  final TodoRepository repository;

  AddTodoImpl({required this.repository});

  @override
  Future<Either<Failure, bool>> call({required Todo data}) async {
    return await repository.addTodo(data: data);
  }
}