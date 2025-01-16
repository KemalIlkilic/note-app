import 'package:flutter/material.dart';
import 'package:koko_first_app/models/note.dart';
import 'package:koko_first_app/models/note_database.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final textController = TextEditingController();
  // create a note
  void createNote() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: TextField(
              controller: textController,
              decoration: const InputDecoration(hintText: 'Enter your note'),
            ),
            actions: [
              MaterialButton(
                onPressed: () => {
                  context.read<NoteDatabase>().addNote(textController.text),
                  Navigator.pop(context),
                },
                child: const Text('Create'),
              ),
              MaterialButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ],
          );
        });
  }

  // read notes
  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  // update a note

  // delete a note

  @override
  Widget build(BuildContext context) {
    // note database
    final noteDatabase = context.watch<NoteDatabase>();

    List<Note> notes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return ListTile(
            title: Text(note.text),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => context.read<NoteDatabase>().deleteNode(note.id),
            ),
          );
        },
      ),
    );
  }
}
