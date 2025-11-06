import 'package:flutter/material.dart';
import 'package:notesme/constants/routes.dart';
import 'package:notesme/enum/menu_action.dart';
import 'package:notesme/provider/counter_provider.dart';
import 'package:notesme/provider/list_map_provider.dart';
import 'package:notesme/services/auth/auth_service.dart';
import 'package:notesme/shared/logout_dailog.dart';
import 'package:provider/provider.dart';

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
      body: Container(
        child: Column(
          children: [
            Consumer<CounterProvider>(
              builder: (ctx, _, __) {
                return Text(
                  ctx.watch<CounterProvider>().getCount().toString(),
                  style: TextStyle(fontSize: 20),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            child: const Text("Add"),
            onPressed: () {
              context.read<CounterProvider>().incrementCount();
            },
          ),
          FloatingActionButton(
            child: const Text("Minus"),
            onPressed: () {
              context.read<CounterProvider>().decrementCount();
            },
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(listRoute, (route) => false);
            },
            child: const Icon(Icons.arrow_back),
          ),
        ],
      ),
    );
  }
}
