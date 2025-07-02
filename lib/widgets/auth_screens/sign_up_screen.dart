import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_flow/generated/l10n.dart';
import 'package:task_flow/widgets/auth_screens/sign_in_screen.dart';
import 'package:task_flow/widgets/base/clickable_text_widget.dart';
import 'package:task_flow/widgets/base/email_input_widget.dart';
import 'package:task_flow/widgets/base/password_input_widget.dart';
import 'package:task_flow/widgets/base/round_button_widget.dart';
import 'package:task_flow/widgets/base/short_input_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;
  bool emailError = true;
  bool passwordError = true;
  bool usernameError = true;
  String? firebaseError;

  final emailRegExp = RegExp(
    r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9_-]+',
  );
  final passwordRegExp = RegExp(
    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z\d!@#$%^&*(),.?":{}|<>]{8,}$',
  );

  void _validateAllFields() {
    final username = usernameController.text.trim();
    setState(() => usernameError = username.isEmpty);

    final email = emailController.text.trim();
    setState(() => emailError = email.isEmpty || !emailRegExp.hasMatch(email));

    final password = passwordController.text.trim();
    setState(
      () =>
          passwordError =
              password.isEmpty || !passwordRegExp.hasMatch(password),
    );
  }

  bool get _isFormValid {
    return !usernameError && !emailError && !passwordError;
  }

  Future<void> _register() async {
    _validateAllFields();

    if (!_isFormValid || isLoading) return;

    setState(() {
      isLoading = true;
      firebaseError = null;
    });

    try {
      final auth = FirebaseAuth.instance;
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await userCredential.user?.updateDisplayName(
        usernameController.text.trim(),
      );
      await userCredential.user?.reload();

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/main');
    } on FirebaseAuthException catch (e) {
      setState(() {
        firebaseError = _getFirebaseErrorMessage(e);
      });
    } catch (e) {
      setState(() {
        firebaseError = S.of(context).registration_failed;
      });
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  String _getFirebaseErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return S.of(context).email_already_in_use;
      case 'invalid-email':
        return S.of(context).invalid_email;
      case 'weak-password':
        return S.of(context).weak_password;
      default:
        return S.of(context).registration_failed;
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                S.of(context).appName,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SvgPicture.asset('assets/svg/team_working.svg', height: 170),
              Text(
                S.of(context).sign_up,
                style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              ShortInputWidget(
                inputController: usernameController,
                label: S.of(context).username,
              ),
              const SizedBox(height: 16),
              EmailInputWidget(
                emailRegExp: emailRegExp,
                emailController: emailController,
              ),
              const SizedBox(height: 16),
              PasswordInputWidget(
                passwordRegExp: passwordRegExp,
                passwordController: passwordController,
              ),
              if (firebaseError != null) ...[
                const SizedBox(height: 16),
                Text(
                  firebaseError!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 32),
              RoundButtonWidget(
                onPressed: _register,
                label: S.of(context).sign_up,
                isLoading: isLoading,
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: ClickableTextWidget(label: S.of(context).sign_in),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
