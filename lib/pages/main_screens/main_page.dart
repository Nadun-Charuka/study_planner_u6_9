import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_planner_u6_9/constants/colors.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              spacing: 10,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Study Planner",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                      ),
                      onPressed: () {
                        GoRouter.of(context).push("/add-new-course");
                      },
                      child: Row(
                        spacing: 5,
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                          Text(
                            "Add Course",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Text(
                  "Your study planner help you to keep track of your study progress and manage your time effectively.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
