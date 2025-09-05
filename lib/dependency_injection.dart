import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_app/feature/auth/data/data_source/auth_remote_datasource.dart';
import 'package:todo_app/feature/auth/data/repositories_impl/auth_repo_impl.dart';
import 'package:todo_app/feature/auth/domain/repositories/auth_repositories.dart';
import 'package:todo_app/feature/auth/domain/use_cases/sign_in_email.dart';
import 'package:todo_app/feature/auth/domain/use_cases/sign_out.dart';
import 'package:todo_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:todo_app/feature/data/data_source/todo_datasource.dart';
import 'package:todo_app/feature/data/repository_imp/todo_repo_imp.dart';
import 'package:todo_app/feature/domain/repositories/todo_repositories.dart';
import 'package:todo_app/feature/domain/usecases/add_todo.dart';
import 'package:todo_app/feature/domain/usecases/complete_todo.dart';
import 'package:todo_app/feature/domain/usecases/delete.dart';
import 'package:todo_app/feature/domain/usecases/fetch_all.dart';
import 'package:todo_app/feature/domain/usecases/fetch_by_id.dart';
import 'package:todo_app/feature/domain/usecases/update.dart';
import 'package:todo_app/feature/presentation/bloc/todo_bloc.dart';

final serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  final firebase = await Firebase.initializeApp();
  serviceLocator.registerLazySingleton(() => firebase);
  serviceLocator.registerLazySingleton(() => FirebaseAuth.instance);
  serviceLocator.registerLazySingleton(() => FirebaseFirestore.instance);
  _initAuth();
  _initTodo();
}

_initAuth() {
  // Auth Feature
  serviceLocator.registerFactory<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(serviceLocator()),
  );

  serviceLocator.registerFactory<AuthRepositories>(
    () => AuthRepoImpl(serviceLocator()),
  );

  serviceLocator.registerFactory<UserSignInWithGoogle>(
    () => UserSignInWithGoogle(serviceLocator()),
  );

  serviceLocator.registerFactory<UserSignOut>(
    () => UserSignOut(serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => AuthBloc(google: serviceLocator(), signOut: serviceLocator()),
  );
}

_initTodo() {
  // Todo Feature
  serviceLocator.registerFactory<TodoDataSource>(
    () => TodoDatasourceImpl(serviceLocator()),
  );

  serviceLocator.registerFactory<TodoRepositories>(
    () => TodoRepoImp(serviceLocator()),
  );

  serviceLocator.registerFactory<AddTodoUseCase>(
    () => AddTodoUseCase(serviceLocator()),
  );

  serviceLocator.registerFactory<FetchByIdUseCase>(
    () => FetchByIdUseCase(serviceLocator()),
  );

  serviceLocator.registerFactory<DeleteToUseCase>(
    () => DeleteToUseCase(serviceLocator()),
  );

  serviceLocator.registerFactory<UpdateTodoUseCase>(
    () => UpdateTodoUseCase(serviceLocator()),
  );

  serviceLocator.registerFactory<FetchAllTodoUseCase>(
    () => FetchAllTodoUseCase(serviceLocator()),
  );

  serviceLocator.registerFactory<CompleteTodoUseCase>(
    () => CompleteTodoUseCase(serviceLocator()),
  );

  serviceLocator.registerFactory<TodoBloc>(
    () => TodoBloc(
      addTodoUseCase: serviceLocator(),
      fetchAllTodoUseCase: serviceLocator(),
      fetchByIdUseCase: serviceLocator(),
      deleteToUseCase: serviceLocator(),
      updateTodoUseCase: serviceLocator(),
      completeTodo: serviceLocator(),
    ),
  );
}
