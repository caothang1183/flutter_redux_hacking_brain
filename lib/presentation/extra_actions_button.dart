// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_redux_hacking_brain/models/extra_action.dart';
import 'package:flutter_redux_hacking_brain/utils/key.dart';
import 'package:flutter_redux_hacking_brain/utils/localization.dart';

class ExtraActionsButton extends StatelessWidget {
  final PopupMenuItemSelected<ExtraAction> onSelected;
  final bool allComplete;

  ExtraActionsButton({
    this.onSelected,
    this.allComplete = false,
    Key key,
  }) : super(key: AppKeys.extraActionsButton);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ExtraAction>(
      onSelected: onSelected,
      itemBuilder: (BuildContext context) => <PopupMenuItem<ExtraAction>>[
            PopupMenuItem<ExtraAction>(
              key: AppKeys.toggleAll,
              value: ExtraAction.toggleAllComplete,
              child: Text(allComplete
                  ? AppLocalizations.of(context).markAllIncomplete
                  : AppLocalizations.of(context).markAllComplete),
            ),
            PopupMenuItem<ExtraAction>(
              key: AppKeys.clearCompleted,
              value: ExtraAction.clearCompleted,
              child: Text(AppLocalizations.of(context).clearCompleted),
            ),
          ],
    );
  }
}
