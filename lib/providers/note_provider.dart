import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_planner_u6_9/models/note_model.dart';
import 'package:study_planner_u6_9/providers/store_images_provider.dart';
import 'package:study_planner_u6_9/services/database/note_service.dart';

class NoteNotifier extends FamilyAsyncNotifier<List<Note>, String> {
  late NoteService api;
  late String courseId;
  @override
  FutureOr<List<Note>> build(String arg) async {
    courseId = arg;
    api = NoteService(courseId: courseId);
    return await api.getNotes();
  }

  Future<void> addNote(Note note, File? imageFile) async {
    String? imageUrl;
    if (imageFile != null) {
      imageUrl = await ref
          .read(storageProvider)
          .uploadImage(noteImage: imageFile, courseId: courseId);
    }
    final newNote = Note(
      id: '',
      title: note.title,
      description: note.description,
      section: note.section,
      reference: note.reference,
      imageUrl: imageUrl,
    );
    final saveNote = await api.createNote(newNote);
    state = AsyncData([...state.value!, saveNote]);
  }
}

final noteProvider =
    AsyncNotifierProviderFamily<NoteNotifier, List<Note>, String>(
        () => NoteNotifier());
