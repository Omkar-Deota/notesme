import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notesme/constants/routes.dart';
import 'package:notesme/firebase_options.dart';
import 'package:notesme/views/login_view.dart';
import 'package:notesme/views/notes_view.dart';
import 'package:notesme/views/register_view.dart';
import 'package:notesme/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load(fileName:".env");
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        verifyUserRoute: (context) => const VerifyEmailView(),
        notesRoute: (context) => const NotesView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null && !user.emailVerified) {
              return const VerifyEmailView();
            }

            if (user != null && user.emailVerified) {
              return const NotesView();
            }

            return const RegisterView();
            default:
            return const CircularProgressIndicator();
          }
      }
    );
  }
}
