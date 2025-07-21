import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:study_planner_u6_9/constants/colors.dart';
import 'package:study_planner_u6_9/providers/assignment_provider.dart';
import 'package:study_planner_u6_9/providers/course_provider.dart';
import 'package:study_planner_u6_9/providers/note_provider.dart';

class CoursesPage extends ConsumerWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courseAsync = ref.watch(courseStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Courses Page"),
      ),
      body: courseAsync.when(
        data: (courses) => ListView.builder(
          padding: EdgeInsets.all(8),
          shrinkWrap: true,
          itemCount: courses.length,
          itemBuilder: (context, index) {
            final course = courses[index];
            final assignmentAsync =
                ref.watch(assignmentStreamProvider(course.id));
            final noteAssync = ref.watch(noteStreamProvider(course.id));
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Description: ${course.description}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'Instructor: ${course.instructor}',
                        style: TextStyle(
                          fontSize: 13,
                          color: lightGreen,
                        ),
                      ),
                      Text(
                        'Duration: ${course.duration}',
                        style: TextStyle(
                          fontSize: 13,
                          color: lightGreen,
                        ),
                      ),
                      Text(
                        'Schedule: ${course.schedule}',
                        style: TextStyle(
                          fontSize: 13,
                          color: lightGreen,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Assignment",
                        style: TextStyle(
                          fontSize: 18,
                          color: primaryColor,
                        ),
                      ),
                      assignmentAsync.when(
                        data: (assignments) => assignments.isNotEmpty
                            ? ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: assignments.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final assignment = assignments[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: GestureDetector(
                                      child: ListTile(
                                        title: Text(assignment.name),
                                        subtitle: Text(
                                            "Due Date: ${assignment.dueDateTime.toString().split(" ")[0]}"),
                                      ),
                                      onTap: () {
                                        GoRouter.of(context).push(
                                            "/single-assignment-page",
                                            extra: assignment);
                                      },
                                    ),
                                  );
                                },
                              )
                            : Text("No Assignments"),
                        error: (error, stackTrace) =>
                            Center(child: Text("Error fetching course")),
                        loading: () => Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Note",
                        style: TextStyle(
                          fontSize: 18,
                          color: primaryColor,
                        ),
                      ),
                      noteAssync.when(
                        data: (notes) => notes.isNotEmpty
                            ? ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: notes.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final note = notes[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: GestureDetector(
                                      child: ListTile(
                                        title: Text(note.title),
                                        subtitle: Text(
                                          note.section,
                                        ),
                                      ),
                                      onTap: () {
                                        GoRouter.of(context).push(
                                          "/single-note-page",
                                          extra: note,
                                        );
                                      },
                                    ),
                                  );
                                },
                              )
                            : Text("No Notes"),
                        error: (error, stackTrace) =>
                            Center(child: Text("Error fetching course")),
                        loading: () => Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        error: (error, stackTrace) =>
            Center(child: Text("Error fetching course")),
        loading: () => Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
