import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_hacking_brain/container/edit_todo.dart';
import 'package:flutter_redux_hacking_brain/models/todo.dart';
import 'package:flutter_redux_hacking_brain/utils/key.dart';
import 'package:flutter_redux_hacking_brain/utils/localization.dart';

class DetailsScreen extends StatelessWidget {
    final Todo todo;
    final Function onDelete;
    final Function(bool) toggleCompleted;

    DetailsScreen({
        Key key,
        @required this.todo,
        @required this.onDelete,
        @required this.toggleCompleted,
    }) : super(key: key ?? AppKeys.todoDetailsScreen);

    @override
    Widget build(BuildContext context) {
        final localizations = AppLocalizations.of(context);

        return Scaffold(
            appBar: AppBar(
                title: Text(localizations.todoDetails),
                actions: [
                    IconButton(
                        tooltip: localizations.deleteTodo,
                        key: AppKeys.deleteTodoButton,
                        icon: Icon(Icons.delete),
                        onPressed: () {
                            onDelete();
                            Navigator.pop(context, todo);
                        },
                    )
                ],
            ),
            body: Padding(
                padding: EdgeInsets.all(16.0),
                child: ListView(
                    children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: Checkbox(
                                        value: todo.complete,
                                        onChanged: toggleCompleted,
                                    ),
                                ),
                                Expanded(
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            Hero(
                                                tag: '${todo.id}__heroTag',
                                                child: Container(
                                                    width: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width,
                                                    padding: EdgeInsets.only(
                                                        top: 8.0,
                                                        bottom: 16.0,
                                                    ),
                                                    child: Text(
                                                        todo.task,
                                                        key: AppKeys.detailsTodoItemTask,
                                                        style: Theme
                                                            .of(context)
                                                            .textTheme
                                                            .headline,
                                                    ),
                                                ),
                                            ),
                                            Text(
                                                todo.note,
                                                key: AppKeys.detailsTodoItemNote,
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .subhead,
                                            ),
                                        ],
                                    ),
                                ),
                            ],
                        ),
                    ],
                ),
            ),
            floatingActionButton: FloatingActionButton(
                key: AppKeys.editTodoFab,
                tooltip: localizations.editTodo,
                child: Icon(Icons.edit),
                onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) {
                                return EditTodo(
                                    todo: todo,
                                );
                            },
                        ),
                    );
                },
            ),
        );
    }
}
