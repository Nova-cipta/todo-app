import 'package:dartz/dartz.dart';
import 'package:todo_app/core/domain/repository/todo_repository.dart';
import 'package:todo_app/core/error/failure.dart';

abstract class CheckUser<Type> {
  Future<Either<Failure, String?>> call();
}

class CheckUserImpl implements CheckUser<String?> {
  final TodoRepository repository;

  CheckUserImpl({required this.repository});

  @override
  Future<Either<Failure, String?>> call() async {
    return await repository.checkUser();
  }
}