import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/core/data/datasource/todo_datasource.dart';
import 'package:todo_app/core/domain/entity/todo.dart';
import 'package:todo_app/core/domain/repository/todo_repository.dart';
import 'package:todo_app/core/error/failure.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoDatasource datasource;

  TodoRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, bool>> addTodo({required Todo data}) async {
    try {
      final result = await datasource.addTodo(data: data);
      return Right(result);
    } on DatabaseException catch (e) {
      log("DatabaseException : ${e.result.toString()}", name: "TodoRepositoryImpl.addTodo");
      return Left(DatabaseFailure(message: e.result.toString()));
    } catch (e) {
      log("message : $e", name: "TodoRepositoryImpl.addTodo");
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String?>> checkUser() async {
    try {
      final result = await datasource.checkUser();
      return Right(result);
    } on DatabaseException catch (e) {
      log("DatabaseException : ${e.result.toString()}", name: "TodoRepositoryImpl.checkUser");
      return Left(DatabaseFailure(message: e.result.toString()));
    } catch (e) {
      log("message : $e", name: "TodoRepositoryImpl.checkUser");
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> setUser({required String name}) async {
    try {
      final result = await datasource.setUser(name: name);
      return Right(result);
    } on DatabaseException catch (e) {
      log("DatabaseException : ${e.result.toString()}", name: "TodoRepositoryImpl.setUser");
      return Left(DatabaseFailure(message: e.result.toString()));
    } catch (e) {
      log("message : $e", name: "TodoRepositoryImpl.setUser");
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> getTodoList({required String name}) async {
    try {
      final result = await datasource.getTodoList(name: name);
      return Right(result);
    } on DatabaseException catch (e) {
      log("DatabaseException : ${e.result.toString()}", name: "TodoRepositoryImpl.getTodoList");
      return Left(DatabaseFailure(message: e.result.toString()));
    } catch (e) {
      log("message : $e", name: "TodoRepositoryImpl.getTodoList");
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> markTodo({required int id}) async{
    try {
      final result = await datasource.markTodo(id: id);
      return Right(result);
    } on DatabaseException catch (e) {
      log("DatabaseException : ${e.result.toString()}", name: "TodoRepositoryImpl.markTodo");
      return Left(DatabaseFailure(message: e.result.toString()));
    } catch (e) {
      log("message : $e", name: "TodoRepositoryImpl.markTodo");
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> removeTodo({required int id}) async{
    try {
      final result = await datasource.removeTodo(id: id);
      return Right(result);
    } on DatabaseException catch (e) {
      log("DatabaseException : ${e.result.toString()}", name: "TodoRepositoryImpl.removeTodo");
      return Left(DatabaseFailure(message: e.result.toString()));
    } catch (e) {
      log("message : $e", name: "TodoRepositoryImpl.removeTodo");
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}