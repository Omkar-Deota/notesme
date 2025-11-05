import 'package:flutter/material.dart';

Future<void> showErrorDailog(
  BuildContext context,
  String text, [
  void Function()? onOkPressed,
]) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text(text),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (onOkPressed != null) onOkPressed();
            },
            child: Text("Ok"),
          ),
        ],
      );
    },
  );
}
