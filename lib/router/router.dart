import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_planner_u6_9/pages/home_page.dart';

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
    ],
  );
}
