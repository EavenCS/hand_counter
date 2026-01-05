import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

AppBar buildAppBar(
  BuildContext context, {
  required VoidCallback onAdd,
  required VoidCallback onFilter,
  required VoidCallback onSettings,
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    leadingWidth: 96,
    leading: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          tooltip: 'Hinzufügen',
          icon: const Icon(CupertinoIcons.add_circled_solid),
          onPressed: onAdd,
        ),
        IconButton(
          tooltip: 'Filter',
          icon: const Icon(CupertinoIcons.line_horizontal_3_decrease),
          onPressed: onFilter,
        ),
      ],
    ),
    actions: [
      IconButton(
        tooltip: 'Einstellungen',
        icon: const Icon(CupertinoIcons.settings),
        onPressed: onSettings,
      ),
    ],
  );
}
