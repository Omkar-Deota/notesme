import 'package:flutter/material.dart';
import 'package:notesme/constants/routes.dart';
import 'package:notesme/services/auth/auth_exception.dart';
import 'package:notesme/services/auth/auth_service.dart';
import 'package:notesme/shared/error_dailog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void handleButtonPress() async {
    final email = _email.text;
    final password = _password.text;


try {
      final sessionUser = await AuthService.firebase().login(
        email: email,
        password: password,
      );

    if (!mounted) return;
      
      if (sessionUser.isEmailVerified == true) {
        Navigator.of(
          context,
      ).pushNamedAndRemoveUntil(notesRoute, (route) => false);
      }
    } on UserNotFoundAuthException {
      await showErrorDailog(context, 'User not found');
    } on WrongPasswordAuthException {
      await showErrorDailog(context, 'Wrong Password');
    } on GenericAuthException {
      await showErrorDailog(context, 'Error logging in');
    }
  }

  void onSignUpButtonPress() {
    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(registerRoute, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ).inversePrimary,
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            decoration: const InputDecoration(hintText: "Enter your Email..."),
            autocorrect: false,
            enableSuggestions: false,
            keyboardType: TextInputType.emailAddress,
          ),
          TextField(
            controller: _password,
            decoration: const InputDecoration(
              hintText: "Enter your Password...",
            ),
            obscureText: true,
            autocorrect: false,
            enableSuggestions: false,
          ),
          TextButton(onPressed: handleButtonPress, child: const Text("Login")),
          TextButton(
            onPressed: onSignUpButtonPress,
            child: const Text("Sign up!!"),
          ),
        ],
      ),
    );
  }
}
