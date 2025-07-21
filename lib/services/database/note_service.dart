import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_planner_u6_9/models/note_model.dart';
import 'package:study_planner_u6_9/services/storage/store_images.dart';

class NoteService {
  final String courseId;
  NoteService({required this.courseId});

  final StorageServices _storageServices = StorageServices();

  CollectionReference get _noteCollection => FirebaseFirestore.instance
      .collection("courses")
      .doc(courseId)
      .collection("notes");

  Stream<List<Note>> streamNotes() {
    return _noteCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Note.fromJson(data, doc.id);
      }).toList();
    });
  }

  Future<Note> createNote(Note note, File? imageFile) async {
    String? imageUrl;

    if (imageFile != null) {
      imageUrl = await _storageServices.uploadImage(
        noteImage: imageFile,
        courseId: courseId,
      );
    }

    final newNote = Note(
      id: '',
      title: note.title,
      description: note.description,
      section: note.section,
      reference: note.reference,
      imageUrl: imageUrl,
    );

    final docRef = await _noteCollection.add(newNote.toJson());
    final doc = await docRef.get();
    return Note.fromJson(doc.data() as Map<String, dynamic>, doc.id);
  }

  Future<void> updateNote(Note note) async {
    await _noteCollection.doc(note.id).update(note.toJson());
  }

  Future<void> deleteNote(String noteId) async {
    await _noteCollection.doc(noteId).delete();
  }
}
