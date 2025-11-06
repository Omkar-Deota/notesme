import 'package:flutter/material.dart';
import 'package:notesme/constants/routes.dart';
import 'package:notesme/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  void verifyEmail() async {
    await AuthService.firebase().sendEmailVerification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify Email")),
      body: Column(
        children: [
          const Text("Please verify your email address to continue."),
          ElevatedButton(
            onPressed: () {
              verifyEmail();

              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(loginRoute, (route) => false);
            },
            child: const Text("Send Verification Email"),
          ),
        ],
      ),
    );
  }
}
