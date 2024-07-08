import 'package:flutter/material.dart';

Future<dynamic> showDialogBottom({
  required BuildContext context,
  required Widget content,
}) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return content;
    },
  );
}
