import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_planner_u6_9/models/assignment_model.dart';

class AssignmentService {
  final String courseId;
  AssignmentService({required this.courseId});

  CollectionReference get _assignmentCollection => FirebaseFirestore.instance
      .collection("courses")
      .doc(courseId)
      .collection("assignment");

  Stream<List<Assignment>> streamAssignments() {
    return _assignmentCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Assignment.fromJson(data, doc.id);
      }).toList();
    });
  }

  Future<Assignment> createAssignment(Assignment assignment) async {
    final docRef = await _assignmentCollection.add(assignment.toJson());
    final doc = await docRef.get();
    return Assignment.fromJson(doc.data() as Map<String, dynamic>, doc.id);
  }

  Future<void> deleteAssignment(String id) async {
    await _assignmentCollection.doc(id).delete();
  }

  Future<void> updateAssignment(String id, Map<String, dynamic> data) async {
    await _assignmentCollection.doc(id).update(data);
  }
}
