import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_hacking_brain/presentation/home_screen.dart';
import 'package:flutter_redux_hacking_brain/redux/actions/todo_actions.dart';
import 'package:flutter_redux_hacking_brain/redux/middleware/store_todos_middleware.dart';
import 'package:flutter_redux_hacking_brain/redux/reducers/app_state_reducers.dart';
import 'package:flutter_redux_hacking_brain/routes.dart';
import 'package:flutter_redux_hacking_brain/theme.dart';
import 'package:flutter_redux_hacking_brain/utils/localization.dart';
import 'package:redux/redux.dart';

import 'container/add_todo.dart';
import 'models/app_state.dart';

class App extends StatelessWidget {

    final store = Store<AppState>(
        appReducer,
        initialState: AppState.loading(),
        middleware: createStoreTodosMiddleware(),
    );

    @override
    Widget build(BuildContext context) {
        return StoreProvider(
            store: store,
            child: MaterialApp(
                title: ReduxLocalizations().appTitle,
                theme: AppTheme.theme,
                localizationsDelegates: [
                    AppLocalizationsDelegate(),
                    ReduxLocalizationsDelegate(),
                ],
                routes: {
                    AppRoutes.home: (context) {
                        return HomeScreen(
                            onInit: () {
                                StoreProvider.of<AppState>(context).dispatch(LoadTodosAction());
                            },
                        );
                    },
                    AppRoutes.addTodo: (context) {
                        return AddTodo();
                    },
                },
            ),
        );
    }
}
