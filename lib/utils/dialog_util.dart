import 'package:flutter/material.dart';
import 'package:task_flow/generated/l10n.dart';

Future<bool?> showUnsavedChangesDialog(BuildContext context) async {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        S.of(context).unsaved_data,
        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      ),
      content: Text(
        S.of(context).want_to_save,
        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            S.of(context).cancel,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            S.of(context).save,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ],
    ),
  );
}