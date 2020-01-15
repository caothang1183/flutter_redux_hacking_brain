import 'package:flutter_redux_hacking_brain/models/app_state.dart';
import 'package:flutter_redux_hacking_brain/redux/reducers/tabs_reducer.dart';
import 'package:flutter_redux_hacking_brain/redux/reducers/todos_reducer.dart';
import 'package:flutter_redux_hacking_brain/redux/reducers/visibility_reducer.dart';


import 'loading_reducer.dart';

AppState appReducer(AppState state, action) {
    return AppState(
        isLoading: loadingReducer(state.isLoading, action),
        todos: todosReducer(state.todos, action),
        activeFilter: visibilityReducer(state.activeFilter, action),
        activeTab: tabsReducer(state.activeTab, action),
    );
}
