import 'package:flutter/material.dart';
import 'package:study_planner_u6_9/constants/colors.dart';
import 'package:study_planner_u6_9/pages/main_screens/assignments_page.dart';
import 'package:study_planner_u6_9/pages/main_screens/courses_page.dart';
import 'package:study_planner_u6_9/pages/main_screens/main_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> pages = [
    MainPage(),
    CoursesPage(),
    AssignmentsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        selectedItemColor: primaryColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: "Course",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_rounded),
            label: "Assignment",
          ),
        ],
      ),
      body: pages[_selectedIndex],
    );
  }
}
