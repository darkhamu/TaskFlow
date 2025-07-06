import 'package:flutter/material.dart';
import 'package:task_flow/generated/l10n.dart';

class PriorityDropdown extends StatelessWidget {
  final int selectedPriority;
  final ValueChanged<int?> onChanged;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const PriorityDropdown({
    super.key,
    required this.selectedPriority,
    required this.onChanged,
    required this.colorScheme,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return DropdownButton<int>(
      value: selectedPriority,
      dropdownColor: colorScheme.surface,
      style: textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurface,
      ),
      items: [
        DropdownMenuItem(
          value: 1,
          child: Text(
            s.urgent,
            style: TextStyle(color: colorScheme.onSurface),
          ),
        ),
        DropdownMenuItem(
          value: 2,
          child: Text(
            s.important,
            style: TextStyle(color: colorScheme.onSurface),
          ),
        ),
        DropdownMenuItem(
          value: 3,
          child: Text(
            s.medium,
            style: TextStyle(color: colorScheme.onSurface),
          ),
        ),
        DropdownMenuItem(
          value: 4,
          child: Text(
            s.have_to_do,
            style: TextStyle(color: colorScheme.onSurface),
          ),
        ),
        DropdownMenuItem(
          value: 5,
          child: Text(
            s.if_possible,
            style: TextStyle(color: colorScheme.onSurface),
          ),
        ),
      ],
      onChanged: onChanged,
    );
  }
}