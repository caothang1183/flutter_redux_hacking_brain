import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_hacking_brain/models/app_state.dart';
import 'package:flutter_redux_hacking_brain/models/todo.dart';
import 'package:flutter_redux_hacking_brain/presentation/add_edit_screen.dart';
import 'package:flutter_redux_hacking_brain/redux/actions/todo_actions.dart';
import 'package:flutter_redux_hacking_brain/utils/key.dart';
import 'package:redux/redux.dart';

class EditTodo extends StatelessWidget {
    final Todo todo;

    EditTodo({this.todo, Key key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return StoreConnector<AppState, OnSaveCallback>(
            converter: (Store<AppState> store) {
                return (task, note) {
                    store.dispatch(UpdateTodoAction(
                        todo.id,
                        todo.copyWith(
                            task: task,
                            note: note,
                        ),
                    ));
                };
            },
            builder: (BuildContext context, OnSaveCallback onSave) {
                return AddEditScreen(
                    key: AppKeys.editTodoScreen,
                    onSave: onSave,
                    isEditing: true,
                    todo: todo,
                );
            },
        );
    }
}
