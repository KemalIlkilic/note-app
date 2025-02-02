import 'package:flutter/material.dart';
import 'package:koko_first_app/models/note_database.dart';
import 'package:koko_first_app/pages/notes_page.dart';
import 'package:provider/provider.dart';

void main() async {
  // initialize the database
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();

  runApp(
    ChangeNotifierProvider(
      create: (context) => NoteDatabase(),
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotesPage(),
    );
  }
}
