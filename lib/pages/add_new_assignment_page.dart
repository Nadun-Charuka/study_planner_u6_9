import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_planner_u6_9/models/assignment_model.dart';
import 'package:study_planner_u6_9/models/course_model.dart';
import 'package:study_planner_u6_9/providers/assignment_provider.dart';
import 'package:study_planner_u6_9/widgets/custom_button.dart';
import 'package:study_planner_u6_9/widgets/custom_input_field.dart';
import 'package:study_planner_u6_9/widgets/custom_snackbar.dart';
import 'package:intl/intl.dart';

class AddNewAssignmentPage extends ConsumerStatefulWidget {
  final Course course;
  const AddNewAssignmentPage({super.key, required this.course});

  @override
  ConsumerState<AddNewAssignmentPage> createState() =>
      _AddNewAssignmentPageState();
}

class _AddNewAssignmentPageState extends ConsumerState<AddNewAssignmentPage> {
  final _formKey = GlobalKey<FormState>();
  final _assignmentNameController = TextEditingController();
  final _assignmentDescriptionController = TextEditingController();
  final _assignmentDurationController = TextEditingController();

  DateTime? _dueDateTime;

  Future<void> _pickDueDateTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2023),
      lastDate: DateTime(2026),
      initialDate: DateTime.now(),
    );

    if (pickedDate == null) return;

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    setState(() {
      _dueDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
    });
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate() || _dueDateTime == null) {
      showSnackBar(
          context, "Please fill all fields and select due date & time");
      return;
    }

    await ref.read(assignmentProvider(widget.course.id).notifier).addAssignment(
          Assignment(
            id: "",
            name: _assignmentNameController.text.trim(),
            description: _assignmentDescriptionController.text.trim(),
            duration: _assignmentDurationController.text.trim(),
            dueDateTime: _dueDateTime!,
          ),
        );

    showSnackBar(context, "Assignment added successfully");
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _assignmentNameController.dispose();
    _assignmentDescriptionController.dispose();
    _assignmentDurationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Assignment')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Fill in the details below to add a new assignment.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                spacing: 10,
                children: [
                  CustomInputField(
                    controller: _assignmentNameController,
                    labelText: "Assignment name",
                    validator: (value) =>
                        (value?.isEmpty ?? true) ? 'Required' : null,
                  ),
                  CustomInputField(
                    controller: _assignmentDescriptionController,
                    labelText: "Assignment description",
                    validator: (value) =>
                        (value?.isEmpty ?? true) ? 'Required' : null,
                  ),
                  CustomInputField(
                    controller: _assignmentDurationController,
                    labelText: "Duration (e.g., 1 hour)",
                    validator: (value) =>
                        (value?.isEmpty ?? true) ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _dueDateTime == null
                              ? "No due date selected"
                              : "Due: ${DateFormat('yyyy-MM-dd hh:mm a').format(_dueDateTime!)}",
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ),
                      IconButton(
                        onPressed: _pickDueDateTime,
                        icon: const Icon(Icons.calendar_today),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: "Add Assignment",
                    onPressed: _submitForm,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
