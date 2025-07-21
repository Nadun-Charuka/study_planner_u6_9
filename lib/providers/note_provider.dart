import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_planner_u6_9/models/note_model.dart';
import 'package:study_planner_u6_9/services/database/note_service.dart';

final noteStreamProvider =
    StreamProvider.family<List<Note>, String>((ref, courseId) {
  return NoteService(courseId: courseId).streamNotes();
});
