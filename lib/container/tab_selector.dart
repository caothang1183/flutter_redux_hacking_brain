// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_hacking_brain/models/app_state.dart';
import 'package:flutter_redux_hacking_brain/models/app_tab.dart';
import 'package:flutter_redux_hacking_brain/redux/actions/app_actions.dart';
import 'package:flutter_redux_hacking_brain/utils/key.dart';
import 'package:flutter_redux_hacking_brain/utils/localization.dart';
import 'package:redux/redux.dart';

class TabSelector extends StatelessWidget {
    TabSelector({Key key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return StoreConnector<AppState, _ViewModel>(
            distinct: true,
            converter: _ViewModel.fromStore,
            builder: (context, vm) {
                return BottomNavigationBar(
                    key: AppKeys.tabs,
                    currentIndex: AppTab.values.indexOf(vm.activeTab),
                    onTap: vm.onTabSelected,
                    items: AppTab.values.map((tab) {
                        return BottomNavigationBarItem(
                            icon: Icon(
                                tab == AppTab.todos ? Icons.list : Icons.show_chart,
                                key: tab == AppTab.todos
                                    ? AppKeys.todoTab
                                    : AppKeys.statsTab,
                            ),
                            title: Text(tab == AppTab.stats
                                ? AppLocalizations
                                .of(context)
                                .stats
                                : AppLocalizations
                                .of(context)
                                .todos),
                        );
                    }).toList(),
                );
            },
        );
    }
}

class _ViewModel {
    final AppTab activeTab;
    final Function(int) onTabSelected;

    _ViewModel({
        @required this.activeTab,
        @required this.onTabSelected,
    });

    static _ViewModel fromStore(Store<AppState> store) {
        return _ViewModel(
            activeTab: store.state.activeTab,
            onTabSelected: (index) {
                store.dispatch(UpdateTabAction((AppTab.values[index])));
            },
        );
    }

    @override
    bool operator ==(Object other) =>
        identical(this, other) ||
            other is _ViewModel &&
                runtimeType == other.runtimeType &&
                activeTab == other.activeTab;

    @override
    int get hashCode => activeTab.hashCode;
}
