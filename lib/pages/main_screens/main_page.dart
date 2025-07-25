import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:study_planner_u6_9/constants/colors.dart';
import 'package:study_planner_u6_9/providers/course_provider.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courseAsync = ref.watch(courseStreamProvider);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                ),
                Text(
                  'Courses',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Your running subjects',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                courseAsync.when(
                  data: (courses) => courses.isNotEmpty
                      ? ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: courses.length,
                          itemBuilder: (context, index) {
                            final course = courses[index];
                            return Card(
                              color: lightGreen,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: ListTile(
                                  title: Text(
                                    course.name,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  subtitle: Text(
                                    course.description,
                                    style: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 12,
                                    ),
                                  ),
                                  onTap: () {
                                    GoRouter.of(context).push(
                                      "/single-course",
                                      extra: course,
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 100.0),
                          child: Center(
                            child: Image.asset(
                              "assets/course.png",
                              width: 300,
                            ),
                          ),
                        ),
                  error: (error, stackTrace) => Text("error"),
                  loading: () => CircularProgressIndicator(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
