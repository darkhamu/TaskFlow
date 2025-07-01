import 'package:flutter/material.dart';
import 'package:task_flow/generated/l10n.dart';
import 'package:task_flow/widgets/base/email_input_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

//Страница регистрации
class _SignUpScreenState extends State<SignUpScreen> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();

  final isButtonEnabled = false;
  final emailRegExp = RegExp(
    r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9_-]+',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).appName), centerTitle: true),
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EmailInputWidget(
                emailController: emailController,
                emailRegExp: emailRegExp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
