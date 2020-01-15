import 'dart:async';
import 'dart:core';

import 'package:flutter_redux_hacking_brain/entity/todo_entity.dart';

abstract class TodosRepository {
    /// Loads todos first from File storage. If they don't exist or encounter an
    /// error, it attempts to load the Todos from a Web Client.
    Future<List<TodoEntity>> loadTodos();

    // Persists todos to local disk and the web
    Future saveTodos(List<TodoEntity> todos);
}
