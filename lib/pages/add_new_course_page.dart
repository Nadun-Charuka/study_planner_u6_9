import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:study_planner_u6_9/models/course_model.dart';
import 'package:study_planner_u6_9/providers/course_provider.dart';
import 'package:study_planner_u6_9/widgets/custom_button.dart';
import 'package:study_planner_u6_9/widgets/custom_input_field.dart';
import 'package:study_planner_u6_9/widgets/custom_snackbar.dart';

class AddNewCoursePage extends ConsumerWidget {
  AddNewCoursePage({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _courseDescriptionController =
      TextEditingController();
  final TextEditingController _courseDurationController =
      TextEditingController();
  final TextEditingController _courseScheduleController =
      TextEditingController();
  final TextEditingController _courseInstructorController =
      TextEditingController();

  void _submitForm(BuildContext context, WidgetRef ref) async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    _formKey.currentState!.save();
    ref.read(courseProvider.notifier).addCourse(
          Course(
            id: "",
            name: _courseNameController.text.trim(),
            description: _courseDescriptionController.text.trim(),
            duration: _courseDurationController.text.trim(),
            schedule: _courseScheduleController.text.trim(),
            instructor: _courseInstructorController.text.trim(),
          ),
        );
    debugPrint("Firestore saved");
    showSnackBar(context, "Course added successfully");
    await Future.delayed(Duration(seconds: 2));
    if (context.mounted) GoRouter.of(context).pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add New Course',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Fill in the details below to add a new course.And start managing your study planner.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                CustomInputField(
                  controller: _courseNameController,
                  labelText: "Course Name",
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Please enter course name";
                    }
                    return null;
                  },
                ),
                CustomInputField(
                  controller: _courseDescriptionController,
                  labelText: 'Course Description',
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a course description';
                    }
                    return null;
                  },
                ),
                CustomInputField(
                  controller: _courseDurationController,
                  labelText: 'Course Duration',
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter the course duration';
                    }
                    return null;
                  },
                ),
                CustomInputField(
                  controller: _courseScheduleController,
                  labelText: 'Course Schedule',
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter the course schedule';
                    }
                    return null;
                  },
                ),
                CustomInputField(
                  controller: _courseInstructorController,
                  labelText: 'Course Instructor',
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter the course instructor';
                    }
                    return null;
                  },
                ),
                CustomButton(
                  text: "Save",
                  onPressed: () async {
                    _submitForm(context, ref);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
