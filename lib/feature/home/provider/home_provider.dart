import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/core/domain/entity/todo.dart';
import 'package:todo_app/core/domain/usecase/add_todo.dart';
import 'package:todo_app/core/domain/usecase/get_todo_list.dart';
import 'package:todo_app/core/domain/usecase/mark_todo.dart';
import 'package:todo_app/core/domain/usecase/remove_todo.dart';
import 'package:todo_app/core/domain/usecase/set_user.dart';

class HomeProvider with ChangeNotifier {
  final AddTodo addTodo;
  final GetTodoList getTodoList;
  final MarkTodo markTodo;
  final RemoveTodo removeTodo;
  final SetUser setUser;

  HomeProvider({
    required this.addTodo,
    required this.getTodoList,
    required this.markTodo,
    required this.removeTodo,
    required this.setUser
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set setLoading(bool val) {
    if (val != isLoading) {
      _isLoading = val;
      notifyListeners();
    }
  }

  List<Todo> _list = [];
  List<Todo> get list => _list;
  Future<void> getList({required String name}) async {
    setLoading = true;

    final result = await getTodoList(name: name);
    result.fold(
      (failure) {
        Fluttertoast.showToast(msg: failure.message);
      },
      (data) {
        _list = data;
      }
    );
    setLoading = false;
  }

  Future<void> add({required Todo data}) async {
    setLoading = true;
    notifyListeners();

    final result = await addTodo(data: data);
    result.fold(
      (failure) {
        Fluttertoast.showToast(msg: failure.message);
        setLoading = false;
      },
      (success) {
        if (success) {
          getList(name: data.assignedTo);
        } else {
          Fluttertoast.showToast(msg: "Fail to add todo");
          setLoading = false;
        }
      }
    );
  }

  Future<bool> mark({required int id}) async {
    final result = await markTodo(id: id);
    return result.fold(
      (failure) {
        Fluttertoast.showToast(msg: failure.message);
        return false;
      },
      (success) {
        if (!success) Fluttertoast.showToast(msg: "Fail to mark todo done");
        return success;
      }
    );
  }

  Future<bool> remove({required int id}) async {
    final result = await removeTodo(id: id);
    return result.fold(
      (failure) {
        Fluttertoast.showToast(msg: failure.message);
        return false;
      },
      (success) {
        if (!success) Fluttertoast.showToast(msg: "Fail to remove todo");
        return success;
      }
    );
  }

  Future<void> logout() async {
    await setUser(name: "");
  }
}