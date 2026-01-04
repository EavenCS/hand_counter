import 'package:flutter/material.dart';

AppBar buildAppBar(
  BuildContext context, {
  required VoidCallback onAdd,
  required VoidCallback onFilter,
  required VoidCallback onSettings,
}) {
  return AppBar(
    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    leadingWidth: 96,
    leading: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          tooltip: 'Hinzufügen',
          icon: const Icon(Icons.add_box),
          onPressed: onAdd,
        ),
        IconButton(
          tooltip: 'Suchen',
          icon: const Icon(Icons.filter_list),
          onPressed: onFilter,
        ),
      ],
    ),
    actions: [
      IconButton(
        tooltip: 'Einstellungen',
        icon: const Icon(Icons.settings),
        onPressed: onSettings,
      ),
    ],
  );
}
