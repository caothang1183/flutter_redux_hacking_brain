import 'package:flutter_redux_hacking_brain/models/app_tab.dart';
import 'package:flutter_redux_hacking_brain/redux/actions/app_actions.dart';
import 'package:redux/redux.dart';

final tabsReducer = combineReducers<AppTab>([
    TypedReducer<AppTab, UpdateTabAction>(_activeTabReducer),
]);

AppTab _activeTabReducer(AppTab activeTab, UpdateTabAction action) {
    return action.newTab;
}
