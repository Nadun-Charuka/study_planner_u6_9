import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_planner_u6_9/models/course_model.dart';
import 'package:study_planner_u6_9/services/database/course_service.dart';

class CourseNotifier extends AsyncNotifier<List<Course>> {
  late CourseService api;
  @override
  Future<List<Course>> build() async {
    api = CourseService();
    return await api.getCourses();
  }

  Future<void> addCourse(Course course) async {
    await api.createCourse(course);
    state = AsyncData([...state.value!, course]);
  }
}

final courseProvider =
    AsyncNotifierProvider<CourseNotifier, List<Course>>(() => CourseNotifier());
