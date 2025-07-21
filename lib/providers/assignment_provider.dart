import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_planner_u6_9/models/assignment_model.dart';
import 'package:study_planner_u6_9/services/database/assignment_service.dart';

final assignmentStreamProvider =
    StreamProvider.family<List<Assignment>, String>((ref, courseId) {
  return AssignmentService(courseId: courseId).streamAssignments();
});
