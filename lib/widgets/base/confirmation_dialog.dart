import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final Color confirmColor;
  final IconData? icon;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmText,
    required this.cancelText,
    this.confirmColor = Colors.red,
    this.icon,
  });

  Future<bool?> show(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: icon != null ? Icon(icon, color: Theme.of(context).colorScheme.primary) : null,
      title: Text(title, style: TextStyle(color: Theme.of(context).colorScheme.onSurface),),
      content: Text(message, style: TextStyle(color: Theme.of(context).colorScheme.onSurface),),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(cancelText),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: TextButton.styleFrom(
            foregroundColor: confirmColor,
          ),
          child: Text(confirmText),
        ),
      ],
    );
  }
}