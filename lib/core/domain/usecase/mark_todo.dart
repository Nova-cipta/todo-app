import 'package:dartz/dartz.dart';
import 'package:todo_app/core/domain/repository/todo_repository.dart';
import 'package:todo_app/core/error/failure.dart';

abstract class MarkTodo<Type> {
  Future<Either<Failure, bool>> call({required int id});
}

class MarkTodoImpl implements MarkTodo<bool> {
  final TodoRepository repository;

  MarkTodoImpl({required this.repository});

  @override
  Future<Either<Failure, bool>> call({required int id}) async {
    return await repository.markTodo(id: id);
  }
}