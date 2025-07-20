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

  Future<List<Course>> getCourses() async {
    final snapshot = await _courseCollection.get();
    return snapshot.docs
        .map((e) => Course.fromJson(e.data() as Map<String, dynamic>, e.id))
        .toList();
  }
}
