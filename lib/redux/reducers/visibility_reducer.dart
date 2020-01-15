import 'package:flutter_redux_hacking_brain/models/visibility_filter.dart';
import 'package:flutter_redux_hacking_brain/redux/actions/app_actions.dart';
import 'package:redux/redux.dart';


final visibilityReducer = combineReducers<VisibilityFilter>([
    TypedReducer<VisibilityFilter, UpdateFilterAction>(_activeFilterReducer),
]);

VisibilityFilter _activeFilterReducer(VisibilityFilter activeFilter, UpdateFilterAction action) {
    return action.newFilter;
}
