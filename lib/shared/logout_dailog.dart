import 'package:flutter/material.dart';

Future<bool?> showLogoutDailog(
  BuildContext context, [
  void Function()? handleLogout,
]) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Logout'),
      content: const Text('Are you sure want to logout ?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text('Cancel'),
        ),
        TextButton(onPressed: handleLogout, child: const Text("Logout")),
      ],
    ),
  );
}
