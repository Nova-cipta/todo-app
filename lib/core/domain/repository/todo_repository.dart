import 'package:dartz/dartz.dart';
import 'package:todo_app/core/domain/entity/todo.dart';
import 'package:todo_app/core/error/failure.dart';

abstract class TodoRepository {
  Future<Either<Failure, String?>> checkUser();
  Future<Either<Failure, bool>> setUser({required String name});
  Future<Either<Failure, List<Todo>>> getTodoList({required String name});
  Future<Either<Failure, bool>> addTodo({required Todo data});
  Future<Either<Failure, bool>> removeTodo({required int id});
  Future<Either<Failure, bool>> markTodo({required int id});
}