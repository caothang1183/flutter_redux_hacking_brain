import 'package:flutter_redux_hacking_brain/models/app_state.dart';
import 'package:flutter_redux_hacking_brain/models/todo.dart';
import 'package:flutter_redux_hacking_brain/network/file_storage.dart';
import 'package:flutter_redux_hacking_brain/redux/actions/app_actions.dart';
import 'package:flutter_redux_hacking_brain/redux/actions/todo_actions.dart';
import 'package:flutter_redux_hacking_brain/repository/repository.dart';
import 'package:flutter_redux_hacking_brain/repository/todos_repository.dart';
import 'package:flutter_redux_hacking_brain/selectors/selectors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redux/redux.dart';


List<Middleware<AppState>> createStoreTodosMiddleware([
    TodosRepository repository = const TodosRepositoryFlutter(
        fileStorage: const FileStorage(
            '__redux_app__',
            getApplicationDocumentsDirectory,
        ),
    ),
]) {
    final saveTodos = _createSaveTodos(repository);
    final loadTodos = _createLoadTodos(repository);

    return [
        TypedMiddleware<AppState, LoadTodosAction>(loadTodos),
        TypedMiddleware<AppState, AddTodoAction>(saveTodos),
        TypedMiddleware<AppState, ClearCompletedAction>(saveTodos),
        TypedMiddleware<AppState, ToggleAllAction>(saveTodos),
        TypedMiddleware<AppState, UpdateTodoAction>(saveTodos),
        TypedMiddleware<AppState, TodosLoadedAction>(saveTodos),
        TypedMiddleware<AppState, DeleteTodoAction>(saveTodos),
    ];
}

Middleware<AppState> _createSaveTodos(TodosRepository repository) {
    return (Store<AppState> store, action, NextDispatcher next) {
        next(action);
        repository.saveTodos(
            todosSelector(store.state).map((todo) => todo.toEntity()).toList(),
        );
    };
}

Middleware<AppState> _createLoadTodos(TodosRepository repository) {
    return (Store<AppState> store, action, NextDispatcher next) {
        repository.loadTodos().then(
                (todos) {
                store.dispatch(
                    TodosLoadedAction(
                        todos.map(Todo.fromEntity).toList(),
                    ),
                );
            },
        ).catchError((_) => store.dispatch(TodosNotLoadedAction()));

        next(action);
    };
}
