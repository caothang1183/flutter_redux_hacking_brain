import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_hacking_brain/container/app_loading.dart';
import 'package:flutter_redux_hacking_brain/container/todo_details.dart';
import 'package:flutter_redux_hacking_brain/models/todo.dart';
import 'package:flutter_redux_hacking_brain/presentation/todo_item.dart';
import 'package:flutter_redux_hacking_brain/utils/key.dart';
import 'package:flutter_redux_hacking_brain/utils/localization.dart';

import 'loading_indicator.dart';

class TodoList extends StatelessWidget {
    final List<Todo> todos;
    final Function(Todo, bool) onCheckboxChanged;
    final Function(Todo) onRemove;
    final Function(Todo) onUndoRemove;

    TodoList({
        Key key,
        @required this.todos,
        @required this.onCheckboxChanged,
        @required this.onRemove,
        @required this.onUndoRemove,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return AppLoading(builder: (context, loading) {
            return loading
                ? LoadingIndicator(key: AppKeys.todosLoading)
                : _buildListView();
        });
    }

    ListView _buildListView() {
        return ListView.builder(
            key: AppKeys.todoList,
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
                final todo = todos[index];

                return TodoItem(
                    todo: todo,
                    onDismissed: (direction) {
                        _removeTodo(context, todo);
                    },
                    onTap: () => _onTodoTap(context, todo),
                    onCheckboxChanged: (complete) {
                        onCheckboxChanged(todo, complete);
                    },
                );
            },
        );
    }

    void _removeTodo(BuildContext context, Todo todo) {
        onRemove(todo);

        Scaffold.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: Theme
                .of(context)
                .backgroundColor,
            content: Text(
                AppLocalizations.of(context).todoDeleted(todo.task),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
            ),
            action: SnackBarAction(
                label: AppLocalizations
                    .of(context)
                    .undo,
                onPressed: () => onUndoRemove(todo),
            )));
    }

    void _onTodoTap(BuildContext context, Todo todo) {
        Navigator
            .of(context)
            .push(MaterialPageRoute(
            builder: (_) => TodoDetails(id: todo.id),
        ))
            .then((removedTodo) {
            if (removedTodo != null) {
                Scaffold.of(context).showSnackBar(SnackBar(
                    key: AppKeys.snackbar,
                    duration: Duration(seconds: 2),
                    backgroundColor: Theme
                        .of(context)
                        .backgroundColor,
                    content: Text(
                        AppLocalizations.of(context).todoDeleted(todo.task),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                    ),
                    action: SnackBarAction(
                        label: AppLocalizations
                            .of(context)
                            .undo,
                        onPressed: () {
                            onUndoRemove(todo);
                        },
                    )));
            }
        });
    }
}
