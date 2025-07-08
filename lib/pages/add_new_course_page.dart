import 'package:flutter/material.dart';
import 'package:study_planner_u6_9/widgets/custom_button.dart';
import 'package:study_planner_u6_9/widgets/custom_input_field.dart';

class AddNewCoursePage extends StatelessWidget {
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

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();
      debugPrint("submited");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
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
                  onPressed: () {
                    _submitForm(context);
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
