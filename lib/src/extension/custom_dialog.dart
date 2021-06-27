import 'package:flutter/material.dart';

Future showErrorAlert(BuildContext context, dynamic error) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 6),
              child: Image.network(
                'https://image.flaticon.com/icons/png/128/564/564619.png',
                height: 20,
                width: 20,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text("Error"),
            ),
          ],
        ),
        content: Text(error.message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK"),
          )
        ],
      );
    },
  );
}
