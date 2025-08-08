import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/core/data/datasource/db_client/database_client.dart';
import 'package:todo_app/core/data/datasource/todo_datasource.dart';
import 'package:todo_app/core/data/repository/todo_repository_impl.dart';
import 'package:todo_app/core/domain/repository/todo_repository.dart';
import 'package:todo_app/core/domain/usecase/add_todo.dart';
import 'package:todo_app/core/domain/usecase/check_user.dart';
import 'package:todo_app/core/domain/usecase/set_user.dart';
import 'package:todo_app/core/domain/usecase/get_todo_list.dart';
import 'package:todo_app/core/domain/usecase/mark_todo.dart';
import 'package:todo_app/core/domain/usecase/remove_todo.dart';
import 'package:todo_app/feature/home/provider/home_provider.dart';
import 'package:todo_app/feature/login/provider/login_provider.dart';

/// [GetIt] is used as service locator this project
final locator = GetIt.instance;

/// initiating all of the services used in this project
init() {
  locator.registerLazySingletonAsync<SharedPreferences>(
    () async => await SharedPreferences.getInstance()
  );

  locator.registerLazySingletonAsync<Database>(
    () async => await DatabaseClient().initDb()
  );

  locator.registerLazySingleton<TodoDatasource>(
    () => TodoDatasourceImpl(
      database: locator<Database>(),
      pref: locator<SharedPreferences>()
    )
  );

  locator.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(datasource: locator<TodoDatasource>())
  );

  locator.registerLazySingleton<AddTodo>(
    () => AddTodoImpl(repository: locator<TodoRepository>())
  );

  locator.registerLazySingleton<CheckUser>(
    () => CheckUserImpl(repository: locator<TodoRepository>())
  );

  locator.registerLazySingleton<SetUser>(
    () => SetUserImpl(repository: locator<TodoRepository>())
  );

  locator.registerLazySingleton<GetTodoList>(
    () => GetTodoListImpl(repository: locator<TodoRepository>())
  );

  locator.registerLazySingleton<MarkTodo>(
    () => MarkTodoImpl(repository: locator<TodoRepository>())
  );

  locator.registerLazySingleton<RemoveTodo>(
    () => RemoveTodoImpl(repository: locator<TodoRepository>())
  );

  locator.registerFactory<LoginProvider>(
    () => LoginProvider(
      checkUser: locator<CheckUser>(),
      setUser: locator<SetUser>()
    )
  );

  locator.registerFactory<HomeProvider>(
    () => HomeProvider(
      addTodo: locator<AddTodo>(),
      getTodoList: locator<GetTodoList>(),
      markTodo: locator<MarkTodo>(),
      removeTodo: locator<RemoveTodo>(),
      setUser:  locator<SetUser>()
    )
  );
}