import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/core/domain/entity/todo.dart';
import 'package:todo_app/core/util/static.dart';

abstract class TodoDatasource {
  Future<String?> checkUser();
  Future<bool> setUser({required String name});
  Future<List<Todo>> getTodoList({required String name});
  Future<bool> addTodo({required Todo data});
  Future<bool> removeTodo({required int id});
  Future<bool> markTodo({required int id});
}

class TodoDatasourceImpl implements TodoDatasource {
  final Database database;
  final SharedPreferences pref;

  TodoDatasourceImpl({required this.database, required this.pref});

  @override
  Future<bool> addTodo({required Todo data}) async {
    try {
      final result = await database.insert(
        tbTodo,
        data.toMap,
        conflictAlgorithm: ConflictAlgorithm.ignore
      );
      return result != 0;
    } catch (e) {
      log("message : $e", name: "TodoDatasourceImpl.addTodo");
      rethrow;
    }
  }

  @override
  Future<String?> checkUser() async {
    return pref.getString(lastUser);
  }

  @override
  Future<bool> setUser({required String name}) async {
    return await pref.setString(lastUser, name);
  }

  @override
  Future<List<Todo>> getTodoList({required String name}) async {
    try {
      final result = await database.query(
        tbTodo,
        where: 'assigned_to = ?',
        whereArgs: [name]
      );
      if (result.isEmpty) {
        return [];
      } else {
        return result.map((entry) => Todo.fromMap(data: entry)).toList();
      }
    } catch (e) {
      log("message : $e", name: "TodoDatasourceImpl.getTodoList");
      rethrow;
    }
  }

  @override
  Future<bool> markTodo({required int id}) async {
    try {
      final update = await database.update(
        tbTodo, {'is_done' : 1}, where: 'id = ?', whereArgs: [id]
      );
      return update != 0;
    } catch (e) {
      log("message : $e", name: "TodoDatasourceImpl.markTodo");
      rethrow;
    }
  }

  @override
  Future<bool> removeTodo({required int id}) async {
    try {
      final result = await database.delete(
        tbTodo, where: 'id = ?', whereArgs: [id]
      );
      return result != 0;
    } catch (e) {
      log("message : $e", name: "TodoDatasourceImpl.removeTodo");
      rethrow;
    }
  }
}