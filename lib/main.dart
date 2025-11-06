import 'package:flutter/material.dart';
import 'package:notesme/constants/routes.dart';
import 'package:notesme/provider/counter_provider.dart';
import 'package:notesme/provider/list_map_provider.dart';
import 'package:notesme/services/auth/auth_service.dart';
import 'package:notesme/views/contact_view.dart';
import 'package:notesme/views/login_view.dart';
import 'package:notesme/views/notes_view.dart';
import 'package:notesme/views/register_view.dart';
import 'package:notesme/views/verify_email_view.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load(fileName: ".env");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CounterProvider()),
        ChangeNotifierProvider(create: (_) => ListMapProvider()),
      ],
      child: MaterialApp(
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
          listRoute: (context) => const ListPage(),
        },
      ),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null && !user.isEmailVerified) {
              return const VerifyEmailView();
            }
            if (user != null && user.isEmailVerified) {
              return const NotesView();
            }
            return const RegisterView();
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
