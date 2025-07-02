import 'package:flutter/material.dart';
import 'package:task_flow/generated/l10n.dart';
import 'package:task_flow/widgets/base/input_field_widget.dart';

//Поле для ввода почты с валидацией
class EmailInputWidget extends StatefulWidget {
  final TextEditingController emailController;
  final RegExp emailRegExp;
  final String? errorText;
  const EmailInputWidget({
    super.key,
    required this.emailController,
    required this.emailRegExp,
    this.errorText,
  });

  @override
  State<EmailInputWidget> createState() => _EmailInputWidgetState();
}

class _EmailInputWidgetState extends State<EmailInputWidget> {
  String? errorText;
  void _validateEmail(String value) {
    setState(
      () =>
          errorText =
              widget.emailRegExp.hasMatch(value)
                  ? null
                  : S.of(context).enter_correct_email,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InputFieldWidget(
      controller: widget.emailController,
      label: S.of(context).email,
      errorText: errorText,
      onChanged: _validateEmail,
      keyboardType: TextInputType.emailAddress,
    );
  }
}
