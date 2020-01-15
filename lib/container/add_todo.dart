// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_hacking_brain/models/app_state.dart';
import 'package:flutter_redux_hacking_brain/models/todo.dart';
import 'package:flutter_redux_hacking_brain/presentation/add_edit_screen.dart';
import 'package:flutter_redux_hacking_brain/redux/actions/todo_actions.dart';
import 'package:flutter_redux_hacking_brain/utils/key.dart';
import 'package:redux/redux.dart';

class AddTodo extends StatelessWidget {
  AddTodo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, OnSaveCallback>(
      converter: (Store<AppState> store) {
        return (task, note) {
          store.dispatch(AddTodoAction(Todo(
            task,
            note: note,
          )));
        };
      },
      builder: (BuildContext context, OnSaveCallback onSave) {
        return AddEditScreen(
          key: AppKeys.addTodoScreen,
          onSave: onSave,
          isEditing: false,
        );
      },
    );
  }
}
