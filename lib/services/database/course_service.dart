import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_planner_u6_9/models/course_model.dart';

class CourseService {
  final CollectionReference _courseCollection =
      FirebaseFirestore.instance.collection("courses");

  Future<Course> createCourse(Course course) async {
    final docRef = await _courseCollection.add(course.toJson());
    final doc = await docRef.get();
    return Course.fromJson(doc.data() as Map<String, dynamic>, doc.id);
  }

  Stream<List<Course>> streamCourses() {
    return _courseCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Course.fromJson(data, doc.id);
      }).toList();
    });
  }

  Future<void> updateCourse(String id, Course updatedCourse) async {
    await _courseCollection.doc(id).update(updatedCourse.toJson());
  }

  Future<void> deleteCourse(String id) async {
    await _courseCollection.doc(id).delete();
  }
}
