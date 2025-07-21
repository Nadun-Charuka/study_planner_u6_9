import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_planner_u6_9/models/course_model.dart';
import 'package:study_planner_u6_9/services/database/course_service.dart';

final courseStreamProvider = StreamProvider<List<Course>>((ref) {
  return CourseService().streamCourses();
});
