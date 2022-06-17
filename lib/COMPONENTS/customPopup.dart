import 'package:flutter/material.dart';

class CustomPopup{
  Widget buildPopupDialog(BuildContext context,String content) {
  return new AlertDialog(
    // title: const Text('Popup example'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("${content}"),
      ],
    ),
    actions: <Widget>[
      new ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        // textColor: Theme.of(context).primaryColor,
        child: Text('Close'),
      ),
    ],
  );
}
}