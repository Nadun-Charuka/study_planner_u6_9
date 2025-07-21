import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_planner_u6_9/models/course_model.dart';
import 'package:study_planner_u6_9/services/database/course_service.dart';
import 'package:study_planner_u6_9/widgets/custom_button.dart';
import 'package:study_planner_u6_9/widgets/custom_input_field.dart';
import 'package:study_planner_u6_9/widgets/custom_snackbar.dart';

class AddNewCoursePage extends ConsumerWidget {
  AddNewCoursePage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _courseNameController = TextEditingController();
  final _courseDescriptionController = TextEditingController();
  final _courseDurationController = TextEditingController();
  final _courseScheduleController = TextEditingController();
  final _courseInstructorController = TextEditingController();

  Future<void> _submitForm(BuildContext context) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    _formKey.currentState!.save();

    await CourseService().createCourse(
      Course(
        id: "",
        name: _courseNameController.text.trim(),
        description: _courseDescriptionController.text.trim(),
        duration: _courseDurationController.text.trim(),
        schedule: _courseScheduleController.text.trim(),
        instructor: _courseInstructorController.text.trim(),
      ),
    );

    if (context.mounted) showSnackBar(context, "Course added successfully");
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
                'Fill in the details below to add a new course and start managing your study planner.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              CustomInputField(
                controller: _courseNameController,
                labelText: "Course Name",
                validator: (value) => (value?.isEmpty ?? true)
                    ? "Please enter course name"
                    : null,
              ),
              CustomInputField(
                controller: _courseDescriptionController,
                labelText: 'Course Description',
                validator: (value) => (value?.isEmpty ?? true)
                    ? 'Please enter description'
                    : null,
              ),
              CustomInputField(
                controller: _courseDurationController,
                labelText: 'Course Duration',
                validator: (value) =>
                    (value?.isEmpty ?? true) ? 'Please enter duration' : null,
              ),
              CustomInputField(
                controller: _courseScheduleController,
                labelText: 'Course Schedule',
                validator: (value) =>
                    (value?.isEmpty ?? true) ? 'Please enter schedule' : null,
              ),
              CustomInputField(
                controller: _courseInstructorController,
                labelText: 'Course Instructor',
                validator: (value) =>
                    (value?.isEmpty ?? true) ? 'Please enter instructor' : null,
              ),
              const SizedBox(height: 16),
              CustomButton(
                text: "Save",
                onPressed: () async {
                  await _submitForm(context);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
