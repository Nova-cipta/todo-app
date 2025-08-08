import 'package:dartz/dartz.dart';
import 'package:todo_app/core/domain/repository/todo_repository.dart';
import 'package:todo_app/core/error/failure.dart';

abstract class RemoveTodo<Type> {
  Future<Either<Failure, bool>> call({required int id});
}

class RemoveTodoImpl implements RemoveTodo<bool> {
  final TodoRepository repository;

  RemoveTodoImpl({required this.repository});

  @override
  Future<Either<Failure, bool>> call({required int id}) async {
    return await repository.removeTodo(id: id);
  }
}