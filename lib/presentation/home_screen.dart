import 'package:flutter/material.dart';
import 'package:flutter_redux_hacking_brain/container/active_tab.dart';
import 'package:flutter_redux_hacking_brain/container/extra_actions_container.dart';
import 'package:flutter_redux_hacking_brain/container/filter_selector.dart';
import 'package:flutter_redux_hacking_brain/container/filtered_todos.dart';
import 'package:flutter_redux_hacking_brain/container/stats.dart';
import 'package:flutter_redux_hacking_brain/container/tab_selector.dart';
import 'package:flutter_redux_hacking_brain/models/app_tab.dart';
import 'package:flutter_redux_hacking_brain/routes.dart';
import 'package:flutter_redux_hacking_brain/utils/key.dart';
import 'package:flutter_redux_hacking_brain/utils/localization.dart';

class HomeScreen extends StatefulWidget {
    final void Function() onInit;
    HomeScreen({Key key, this.onInit}) : super(key: key);
    @override
    _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    @override
    void initState() {
        widget.onInit();
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
        return ActiveTab(
            builder: (BuildContext context, AppTab activeTab){
                return Scaffold(
                    appBar: AppBar(
                        title: Text(ReduxLocalizations.of(context).appTitle),
                        actions: [
                            FilterSelector(visible: activeTab == AppTab.todos),
                            ExtraActionsContainer(),
                        ],
                    ),
                    body: activeTab == AppTab.todos ? FilteredTodos() : Stats(),
                    floatingActionButton: FloatingActionButton(
                        key: AppKeys.addTodoFab,
                        onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.addTodo);
                        },
                        child: Icon(Icons.add),
                        tooltip: AppLocalizations.of(context).addTodo,
                    ),
                    bottomNavigationBar: TabSelector(),
                );
            }
        );
    }
}