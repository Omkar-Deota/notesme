import 'package:flutter/material.dart';
import 'package:notesme/constants/routes.dart';
import 'package:notesme/services/auth/auth_exception.dart';
import 'package:notesme/services/auth/auth_service.dart';
import 'package:notesme/shared/error_dailog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
      final userCredential = await AuthService.firebase().createUser(
        email: email,
        password: password,
      );

      if (!mounted) {
        return;
      }

      if (userCredential.isEmailVerified) {
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(verifyUserRoute, (route) => false);
      }
    } on WeakPasswordAuthException {
      await showErrorDailog(context, "Weak Password");
    } on EmailAlreadyInUseAuthException {
      await showErrorDailog(context, "Email already in use");
    } on InvalidEmailAuthException {
      await showErrorDailog(context, "Invalid Email");
    } on GenericAuthException catch (e) {
      await showErrorDailog(context, e.toString());
    }
  }

  void onRedirectLoginPress() {
    Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        backgroundColor: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ).inversePrimary,
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            decoration: InputDecoration(hintText: "Enter your Email..."),
            autocorrect: false,
            enableSuggestions: false,
            keyboardType: TextInputType.emailAddress,
          ),
          TextField(
            controller: _password,
            decoration: InputDecoration(hintText: "Enter your Password..."),
            obscureText: true,
            autocorrect: false,
            enableSuggestions: false,
          ),
          TextButton(
            onPressed: handleButtonPress,
            child: const Text("Register"),
          ),
          TextButton(
            onPressed: onRedirectLoginPress,
            child: const Text("Back to login!!"),
          ),
        ],
      ),
    );
  }
}
