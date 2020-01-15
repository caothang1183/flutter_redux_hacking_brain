import 'package:flutter_redux_hacking_brain/models/app_tab.dart';
import 'package:flutter_redux_hacking_brain/models/visibility_filter.dart';

class ClearCompletedAction {}

class ToggleAllAction {}

class UpdateFilterAction {
    final VisibilityFilter newFilter;

    UpdateFilterAction(this.newFilter);

    @override
    String toString() {
        return 'UpdateFilterAction{newFilter: $newFilter}';
    }
}

class UpdateTabAction {
    final AppTab newTab;

    UpdateTabAction(this.newTab);

    @override
    String toString() {
        return 'UpdateTabAction{newTab: $newTab}';
    }
}
