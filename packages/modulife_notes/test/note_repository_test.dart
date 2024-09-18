import 'package:flutter_test/flutter_test.dart';
import 'package:modulife_notes/models/note.dart';
import 'package:modulife_notes/repositories/note_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore_for_file: unused_local_variable
void main() {
  late NoteRepository noteRepository;
  late SharedPreferences prefs;

  setUp(() async {
    // Clear SharedPreferences before each test
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    noteRepository = NoteRepository();
  });

  test('Save and load notes', () async {
    // Create sample notes
    final List<Note> notes = [
      Note(title: 'Test Note 1', content: 'Content 1'),
      Note(title: 'Test Note 2', content: 'Content 2'),
    ];

    // Save the notes
    await noteRepository.saveNotes(notes);

    // Load the notes
    final List<Note> loadedNotes = await noteRepository.loadNotes();

    // Validate if saved notes match loaded notes
    expect(loadedNotes.length, 2);
    expect(loadedNotes[0].title, 'Test Note 1');
    expect(loadedNotes[1].content, 'Content 2');
  });

  test('Clear notes', () async {
    // Create and save a note
    final Note note = Note(title: 'Note to clear');
    await noteRepository.saveNotes([note]);

    // Clear the notes
    await noteRepository.clearNotes();

    // Load notes and expect empty list
    final List<Note> loadedNotes = await noteRepository.loadNotes();
    expect(loadedNotes.isEmpty, true);
  });
}
