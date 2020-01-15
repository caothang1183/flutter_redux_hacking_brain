import 'package:flutter_redux_hacking_brain/redux/actions/todo_actions.dart';
import 'package:redux/redux.dart';

final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, TodosLoadedAction>(_setLoaded),
  TypedReducer<bool, TodosNotLoadedAction>(_setLoaded),
]);

bool _setLoaded(bool state, action) {
  return false;
}
