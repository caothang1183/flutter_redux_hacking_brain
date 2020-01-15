import 'package:flutter_redux_hacking_brain/models/todo.dart';

class LoadTodosAction {}

class TodosNotLoadedAction {}

class TodosLoadedAction {
    final List<Todo> todos;

    TodosLoadedAction(this.todos);

    @override
    String toString() {
        return 'TodosLoadedAction{todos: $todos}';
    }
}

class UpdateTodoAction {
    final String id;
    final Todo updatedTodo;

    UpdateTodoAction(this.id, this.updatedTodo);

    @override
    String toString() {
        return 'UpdateTodoAction{id: $id, updatedTodo: $updatedTodo}';
    }
}

class DeleteTodoAction {
    final String id;

    DeleteTodoAction(this.id);

    @override
    String toString() {
        return 'DeleteTodoAction{id: $id}';
    }
}

class AddTodoAction {
    final Todo todo;

    AddTodoAction(this.todo);

    @override
    String toString() {
        return 'AddTodoAction{todo: $todo}';
    }
}
