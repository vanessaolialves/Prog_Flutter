import 'package:flutter/material.dart';

class NoteDelete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Cuidado'),
      content: Text('Você tem certeza que quer deletar esse produto?'),
      actions: <Widget>[
        // ignore: deprecated_member_use
        FlatButton(
          child: Text('Sim'),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        // ignore: deprecated_member_use
        FlatButton(
          child: Text('Não'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ],
    );
  }
}
