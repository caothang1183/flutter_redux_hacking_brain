import 'package:flutter_redux_hacking_brain/entity/todo_entity.dart';
import 'package:flutter_redux_hacking_brain/models/app_state.dart';
import 'package:flutter_redux_hacking_brain/models/todo.dart';
import 'package:flutter_redux_hacking_brain/redux/actions/app_actions.dart';
import 'package:flutter_redux_hacking_brain/redux/actions/todo_actions.dart';
import 'package:flutter_redux_hacking_brain/redux/middleware/store_todos_middleware.dart';
import 'package:flutter_redux_hacking_brain/redux/reducers/app_state_reducers.dart';
import 'package:flutter_redux_hacking_brain/repository/todos_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';


class MockTodosRepository extends Mock implements TodosRepository {}

main() {
    group('Save State Middleware', () {
        test('should load the todos in response to a LoadTodosAction', () {
            final repository = MockTodosRepository();
            final store = Store<AppState>(
                appReducer,
                initialState: AppState.loading(),
                middleware: createStoreTodosMiddleware(repository),
            );
            final todos = [
                TodoEntity("Moin", "1", "Note", false),
            ];

            when(repository.loadTodos()).thenAnswer((_) => Future.value(todos));

            store.dispatch(LoadTodosAction());

            verify(repository.loadTodos());
        });

        test('should save the state on every update action', () {
            final repository = MockTodosRepository();
            final store = Store<AppState>(
                appReducer,
                initialState: AppState.loading(),
                middleware: createStoreTodosMiddleware(repository),
            );
            final todo = Todo("Hallo");

            store.dispatch(AddTodoAction(todo));
            store.dispatch(ClearCompletedAction());
            store.dispatch(ToggleAllAction());
            store.dispatch(TodosLoadedAction([Todo("Hi")]));
            store.dispatch(ToggleAllAction());
            store.dispatch(UpdateTodoAction("", Todo("")));
            store.dispatch(DeleteTodoAction(""));

            verify(repository.saveTodos(any)).called(7);
        });
    });
}
