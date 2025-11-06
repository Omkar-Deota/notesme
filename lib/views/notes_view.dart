import 'package:flutter/material.dart';
import 'package:notesme/constants/routes.dart';
import 'package:notesme/enum/menu_action.dart';
import 'package:notesme/services/auth/auth_service.dart';
import 'package:notesme/shared/logout_dailog.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  void handleLogout() async {
    await AuthService.firebase().logout();
    if (!mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        backgroundColor: Colors.amber,
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              switch (value) {
                case MenuAction.logout:
                  showLogoutDailog(context, handleLogout);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem<MenuAction>(
                value: MenuAction.logout,
                child: ListTile(title: const Text('Logout')),
              ),
            ],
          ),
        ],
      ),
      body: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
