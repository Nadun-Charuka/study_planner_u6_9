import 'package:flutter/material.dart';
import 'package:study_planner_u6_9/models/course_model.dart';
import 'package:study_planner_u6_9/widgets/custom_button.dart';
import 'package:study_planner_u6_9/widgets/custom_input_field.dart';
import 'package:study_planner_u6_9/widgets/custom_snackbar.dart';

class AddNewAssignmentPage extends StatelessWidget {
  final Course course;

  AddNewAssignmentPage({
    super.key,
    required this.course,
  }) {
    _selectedDate.value = DateTime.now();
    _selectedTime.value = TimeOfDay.now();
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _assignmentNameController =
      TextEditingController();
  final TextEditingController _assignmentDescriptionController =
      TextEditingController();
  final TextEditingController _assignmentDurationController =
      TextEditingController();

  final ValueNotifier<DateTime> _selectedDate =
      ValueNotifier<DateTime>(DateTime.now());
  final ValueNotifier<TimeOfDay> _selectedTime =
      ValueNotifier<TimeOfDay>(TimeOfDay.now());

  Future<void> datePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2023),
      lastDate: DateTime(2026),
    );

    if (picked != null && picked != _selectedDate.value) {
      _selectedDate.value = picked;
    }
  }

  Future<void> timePicker(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime.value,
    );

    if (picked != null && picked != _selectedTime.value) {
      _selectedTime.value = picked;
    }
  }

  //submit form
  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      debugPrint("From valid");
      showSnackBar(context, "Assignment added sucessfully");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: [
              const Text(
                'Add New Assignment',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              //description
              const Text(
                'Fill in the details below to add a new assignment. And start managing your study planner.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  spacing: 10,
                  children: [
                    // "value?.isEmpty ?? true "can return true,false,null so if null we assueme it as true
                    CustomInputField(
                      controller: _assignmentNameController,
                      labelText: "Assignment name",
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter the assignment name';
                        }
                        return null;
                      },
                    ),
                    CustomInputField(
                      controller: _assignmentDescriptionController,
                      labelText: "Assignment description",
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter the assignment description';
                        }
                        return null;
                      },
                    ),
                    CustomInputField(
                      controller: _assignmentDurationController,
                      labelText: "Duration (e.g., 1 hour)",
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter the assignment duration';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Divider(),
              const Text(
                'Due Date and Time',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white60,
                ),
              ),
              const SizedBox(height: 16),
              ValueListenableBuilder(
                valueListenable: _selectedDate,
                builder: (context, date, child) {
                  return Row(
                    children: [
                      Expanded(
                        child: Text(
                            "Date : ${date.toLocal().toString().split(" ")[0]}"),
                      ),
                      IconButton(
                        onPressed: () {
                          datePicker(context);
                        },
                        icon: Icon(Icons.calendar_month),
                      )
                    ],
                  );
                },
              ),
              ValueListenableBuilder(
                valueListenable: _selectedTime,
                builder: (context, time, child) {
                  return Row(
                    children: [
                      Expanded(
                        child: Text("Time : ${time.format(context)}"),
                      ),
                      IconButton(
                        onPressed: () {
                          timePicker(context);
                        },
                        icon: Icon(Icons.access_time),
                      )
                    ],
                  );
                },
              ),
              CustomButton(
                text: "Add Assignment",
                onPressed: () {
                  _submitForm(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
