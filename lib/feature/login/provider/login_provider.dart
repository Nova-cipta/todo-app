import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/core/domain/usecase/check_user.dart';
import 'package:todo_app/core/domain/usecase/set_user.dart';

class LoginProvider with ChangeNotifier {
  final CheckUser checkUser;
  final SetUser setUser;

  LoginProvider({required this.checkUser, required this.setUser});

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  set setLoading(bool val) {
    if (val != _isLoading) {
      _isLoading = val;
      notifyListeners();
    }
  }

  Future<String?> check() async {
    final result = await checkUser();
    return result.fold(
      (failure) {
        Fluttertoast.showToast(msg: failure.message);
        return null;
      },
      (data) {
        return data;
      }
    );
  }

  Future<void> login({required String name}) async {
    setLoading = true;

    final result = await setUser(name: name);
    result.fold(
      (failure) {
        log(failure.message);
        return null;
      },
        (data) {
        return data;
      }
    );
  }
}