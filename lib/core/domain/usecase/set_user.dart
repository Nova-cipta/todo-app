import 'package:dartz/dartz.dart';
import 'package:todo_app/core/domain/repository/todo_repository.dart';
import 'package:todo_app/core/error/failure.dart';

abstract class SetUser<Type> {
  Future<Either<Failure, bool>> call({required String name});
}

class SetUserImpl implements SetUser<bool> {
  final TodoRepository repository;

  SetUserImpl({required this.repository});

  @override
  Future<Either<Failure, bool>> call({required String name}) async {
    return await repository.setUser(name: name);
  }
}