import 'package:flutter/material.dart';
import 'package:task_flow/generated/l10n.dart';
import 'package:task_flow/widgets/base/input_field_widget.dart';

//Маленькие однострочные поля для текста
class ShortInputWidget extends StatefulWidget {
  final TextEditingController inputController;
  final String label;
  const ShortInputWidget({
    super.key,
    required this.inputController,
    required this.label,
  });

  @override
  State<ShortInputWidget> createState() => _ShortInputWidgetState();
}

class _ShortInputWidgetState extends State<ShortInputWidget> {
  String? _errorText;
  void _validateInput(String value) {
    setState(
      () =>
          _errorText =
              value.isEmpty ? S.of(context).field_must_be_filled : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InputFieldWidget(
      controller: widget.inputController,
      label: widget.label,
      onChanged: _validateInput,
      errorText: _errorText,
    );
  }
}
