import 'package:isar/isar.dart';
import 'package:koko_first_app/models/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase {
  //static: This keyword means the variable belongs to the class itself, not instances of the class.
  //late: You're promising Dart "I will set this value before using it.
  static late Isar isar;

  // INITIALIZE DATABASE
  //static: Like the isar variable, this method belongs to the class itself
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    //[NoteSchema]: List of schemas (database models) to use
    //directory: dir.path: Where to store the database file
    isar = await Isar.open(
      [NoteSchema],
      directory: dir.path,
    );
  }

  //list of notes
  final List<Note> currentNotes = [];

  // CREATE - a note and save to db
  Future<void> addNote(String text) async {
    final newNote = Note()..text = text;
    await isar.writeTxn(() => isar.notes.put(newNote));
    await fetchNotes();
  }

  // READ - notes from db
  Future<void> fetchNotes() async {
    List<Note> fetchedNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
  }

  // UPDATE - a note in db
  Future<void> updateNode(int id, String newText) async {
    final note = await isar.notes.get(id);
    if (note != null) {
      note.text = newText;
      await isar.writeTxn(() => isar.notes.put(note));
      await fetchNotes();
    }
  }

  // DELETE - a note
  Future<void> deleteNode(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await fetchNotes();
  }
}
