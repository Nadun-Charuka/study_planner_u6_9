import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_planner_u6_9/models/assignment_model.dart';
import 'package:study_planner_u6_9/models/course_model.dart';
import 'package:study_planner_u6_9/models/note_model.dart';
import 'package:study_planner_u6_9/pages/add_new_assignment_page.dart';
import 'package:study_planner_u6_9/pages/add_new_course_page.dart';
import 'package:study_planner_u6_9/pages/add_new_note_page.dart';
import 'package:study_planner_u6_9/pages/home_page.dart';
import 'package:study_planner_u6_9/pages/single_assignment_page.dart';
import 'package:study_planner_u6_9/pages/single_course_page.dart';
import 'package:study_planner_u6_9/pages/single_note_page.dart';

class RouterClass {
  static final router = GoRouter(
    initialLocation: "/",
    errorPageBuilder: (context, state) {
      return MaterialPage(
        child: Scaffold(
          body: Center(child: Text("This page is not available")),
        ),
      );
    },
    routes: [
      //homepage
      GoRoute(
        path: "/",
        name: "home",
        builder: (context, state) => HomePage(),
      ),

      GoRoute(
        path: "/add-new-course",
        name: "add new course",
        builder: (context, state) => AddNewCoursePage(),
      ),
      GoRoute(
        path: "/single-course",
        name: "single course",
        builder: (context, state) {
          final Course course = state.extra as Course;
          return SingleCoursePage(
            course: course,
          );
        },
      ),
      GoRoute(
        path: "/add-new-assignment",
        name: "add new assignment",
        builder: (context, state) {
          final Course course = state.extra as Course;
          return AddNewAssignmentPage(
            course: course,
          );
        },
      ),
      GoRoute(
        path: "/add-new-note",
        name: "add new note",
        builder: (context, state) {
          final Course course = state.extra as Course;
          return AddNewNotePage(
            course: course,
          );
        },
      ),
      GoRoute(
        path: "/single-note-page",
        name: "single note page",
        builder: (context, state) {
          final Note note = state.extra as Note;
          return SingleNotePage(note: note);
        },
      ),
      GoRoute(
        path: "/single-assignment-page",
        name: "single assignment page",
        builder: (context, state) {
          final Assignment assignment = state.extra as Assignment;
          return SingleAssignmentPage(assignment: assignment);
        },
      )
    ],
  );
}
