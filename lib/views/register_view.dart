import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notesme/firebase_options.dart';

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

    print("$password $email");

    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      print(userCredential);
    } catch (e) {
      print(e.toString());
    }
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
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
                children: [
                  TextField(
                    controller: _email,
                    decoration: InputDecoration(
                      hintText: "Enter your Email...",
                    ),
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextField(
                    controller: _password,
                    decoration: InputDecoration(
                      hintText: "Enter your Password...",
                    ),
                    obscureText: true,
                    autocorrect: false,
                    enableSuggestions: false,
                  ),
                  TextButton(
                    onPressed: handleButtonPress,
                    child: const Text("Register"),
                  ),
                ],
              );
            default:
              return Text("Loading");
          }
        },
      ),
    );
  }
}
