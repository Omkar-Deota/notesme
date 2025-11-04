import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notesme/firebase_options.dart';
import 'package:notesme/views/login_view.dart';
import 'package:notesme/views/register_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  bool isEmailVerified() {
    final user = FirebaseAuth.instance.currentUser;
    if (user?.emailVerified ?? false) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Note Me"),
        backgroundColor: Colors.greenAccent,
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (isEmailVerified()) {
                return const Text('Done');
              } else {
                return const Text("Email verification Pending");
              }
            default:
              return const Text("Loading");
          }
        },
      ),
    );
  }
}
