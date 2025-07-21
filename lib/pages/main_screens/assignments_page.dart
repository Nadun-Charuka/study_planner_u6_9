import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_planner_u6_9/providers/assignment_provider.dart';
import 'package:study_planner_u6_9/providers/course_provider.dart';
import 'package:study_planner_u6_9/widgets/countdown_timer.dart';

class AssignmentsPage extends ConsumerWidget {
  const AssignmentsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courseAsync = ref.watch(courseProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Assignments")),
      body: courseAsync.when(
        data: (courses) => ListView.builder(
          itemCount: courses.length,
          itemBuilder: (context, courseIndex) {
            final course = courses[courseIndex];
            final assignmentAsync = ref.watch(assignmentProvider(course.id));

            return assignmentAsync.when(
              data: (assignments) => ExpansionTile(
                title: Text(course.name),
                children: assignments.isEmpty
                    ? [
                        ListTile(
                          title: Text(
                            "No Assignments",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ]
                    : assignments.map((assignment) {
                        return ListTile(
                          title: Text(assignment.name),
                          subtitle:
                              CountdownTimer(dueDate: assignment.dueDateTime),
                        );
                      }).toList(),
              ),
              error: (error, stackTrace) =>
                  ListTile(title: Text("Error loading assignments")),
              loading: () => ListTile(
                title: Row(
                  children: [
                    CircularProgressIndicator(strokeWidth: 2),
                    SizedBox(width: 10),
                    Text("Loading assignments..."),
                  ],
                ),
              ),
            );
          },
        ),
        error: (error, stackTrace) =>
            Center(child: Text("Error loading courses")),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
