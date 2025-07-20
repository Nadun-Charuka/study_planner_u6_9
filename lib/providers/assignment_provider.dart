import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_planner_u6_9/models/assignment_model.dart';
import 'package:study_planner_u6_9/services/database/assignment_service.dart';

class AssignmentNotifier extends FamilyAsyncNotifier<List<Assignment>, String> {
  late AssignmentService api;
  late String courseId;

  @override
  Future<List<Assignment>> build(String arg) async {
    courseId = arg;
    api = AssignmentService(courseId: courseId);
    return await api.getAssignments();
  }

  Future<void> addAssignment(Assignment assignment) async {
    final newAssignment = await api.createAssignment(assignment);
    state = AsyncData([...state.value!, newAssignment]);
  }
}

final assignmentProvider =
    AsyncNotifierProviderFamily<AssignmentNotifier, List<Assignment>, String>(
        () => AssignmentNotifier());
