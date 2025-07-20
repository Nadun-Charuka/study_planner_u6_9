import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_planner_u6_9/models/assignment_model.dart';

class AssignmentService {
  final String courseId;
  AssignmentService({required this.courseId});

  CollectionReference get _assignmentCollection => FirebaseFirestore.instance
      .collection("courses")
      .doc(courseId)
      .collection("assignment");

  Future<Assignment> createAssignment(Assignment assignment) async {
    final docRef = await _assignmentCollection.add(assignment.toJson());
    final doc = await docRef.get();
    return Assignment.fromJson(doc.data() as Map<String, dynamic>, doc.id);
  }

  Future<List<Assignment>> getAssignments() async {
    final snapshot = await _assignmentCollection.get();
    return snapshot.docs
        .map((e) => Assignment.fromJson(e.data() as Map<String, dynamic>, e.id))
        .toList();
  }
}
