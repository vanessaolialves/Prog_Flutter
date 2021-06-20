import 'package:flutter/material.dart';
import 'package:flutterapirestful/services/notes_service.dart';
import 'package:flutterapirestful/view/note_list.dart';
import 'package:get_it/get_it.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => NotesService());
}

/*

Aplicativo com RestAPI

Alunas:
    Giovanna de Sousa Sampaio
    Vanessa Oliveira Alves

*/

void main() {
  setupLocator();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: NoteList(),
    );
  }
}
