import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_hacking_brain/models/app_state.dart';
import 'package:flutter_redux_hacking_brain/models/extra_action.dart';
import 'package:flutter_redux_hacking_brain/presentation/extra_actions_button.dart';
import 'package:flutter_redux_hacking_brain/redux/actions/app_actions.dart';
import 'package:flutter_redux_hacking_brain/selectors/selectors.dart';
import 'package:redux/redux.dart';

class ExtraActionsContainer extends StatelessWidget {
    ExtraActionsContainer({Key key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return StoreConnector<AppState, _ViewModel>(
            distinct: true,
            converter: _ViewModel.fromStore,
            builder: (context, vm) {
                return ExtraActionsButton(
                    allComplete: vm.allComplete,
                    onSelected: vm.onActionSelected,
                );
            },
        );
    }
}

class _ViewModel {
    final Function(ExtraAction) onActionSelected;
    final bool allComplete;

    _ViewModel({
        @required this.onActionSelected,
        @required this.allComplete,
    });

    static _ViewModel fromStore(Store<AppState> store) {
        return _ViewModel(
            onActionSelected: (action) {
                if (action == ExtraAction.clearCompleted) {
                    store.dispatch(ClearCompletedAction());
                } else if (action == ExtraAction.toggleAllComplete) {
                    store.dispatch(ToggleAllAction());
                }
            },
            allComplete: allCompleteSelector(todosSelector(store.state)),
        );
    }

    @override
    bool operator ==(Object other) =>
        identical(this, other) ||
            other is _ViewModel &&
                runtimeType == other.runtimeType &&
                allComplete == other.allComplete;

    @override
    int get hashCode => allComplete.hashCode;
}
