import 'package:isar/isar.dart';

// this line is required to generate the .g.dart file
// then run the command: flutter pub run build_runner build
part 'note.g.dart';

@Collection()
class Note {
  Id id = Isar.autoIncrement;
  late String text;
}
