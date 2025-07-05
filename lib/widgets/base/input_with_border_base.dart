import 'package:flutter/material.dart';

class InputWithBorderBase extends StatelessWidget {
  final String name;
  final TextEditingController controller;
  final int maxLines;
  final String? errorText;

  const InputWithBorderBase({super.key, required this.name, required this.controller, this.errorText, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      controller: controller,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        labelText: name,
        errorText: errorText,
        labelStyle: TextStyle(
          fontSize: 14,
          color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
        ),
        floatingLabelStyle: TextStyle(
          color:
          errorText != null
              ? Theme.of(context).colorScheme.error
              : Theme.of(context).colorScheme.primary,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(width: 1.0, color: Theme.of(context).colorScheme.onSurface),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(width: 1.5, color: Theme.of(context).colorScheme.onSurface),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
              width: 1.5,),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
              width: 1.5,),
        ),
      ),
    );
  }
}
