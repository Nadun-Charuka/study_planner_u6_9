import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_planner_u6_9/models/note_model.dart';

class NoteService {
  final String courseId;
  NoteService({required this.courseId});

  CollectionReference get _noteCollection => FirebaseFirestore.instance
      .collection("courses")
      .doc(courseId)
      .collection("notes");

  Future<Note> createNote(Note note) async {
    final docRef = await _noteCollection.add(note.toJson());
    final doc = await docRef.get();
    return Note.fromJson(doc.data() as Map<String, dynamic>, doc.id);
  }

  Future<List<Note>> getNotes() async {
    final snapshot = await _noteCollection.get();
    return snapshot.docs
        .map((e) => Note.fromJson(e.data() as Map<String, dynamic>, e.id))
        .toList();
  }
}
