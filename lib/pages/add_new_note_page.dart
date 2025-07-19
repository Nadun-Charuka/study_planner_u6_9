import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:study_planner_u6_9/models/course_model.dart';
import 'package:study_planner_u6_9/widgets/custom_button.dart';
import 'package:study_planner_u6_9/widgets/custom_input_field.dart';
import 'package:study_planner_u6_9/widgets/custom_snackbar.dart';

class AddNewNotePage extends StatefulWidget {
  final Course course;
  const AddNewNotePage({
    super.key,
    required this.course,
  });

  @override
  State<AddNewNotePage> createState() => _AddNewNotePageState();
}

class _AddNewNotePageState extends State<AddNewNotePage> {
  final _fromKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _sectionController = TextEditingController();

  final TextEditingController _referencesController = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();

  XFile? _selectedImage;

  Future<void> _pickImage() async {
    final XFile? _image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = _image;
    });
  }

  void _clearAllFields() {
    _titleController.clear();
    _descriptionController.clear();
    _sectionController.clear();
    _referencesController.clear();
  }

  void _submintForm(BuildContext context) async {
    if (_fromKey.currentState?.validate() ?? false) {
      debugPrint("valid form");
      showSnackBar(context, "Note save Successfully");
      _clearAllFields();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _sectionController.dispose();
    _referencesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add New Note For Your Course',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Fill in the details below to add a new note. And start managing your study planner.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            Form(
              key: _fromKey,
              child: Column(
                spacing: 10,
                children: [
                  CustomInputField(
                    controller: _titleController,
                    labelText: "Note Title",
                    validator: (value) {
                      if (value?.isEmpty ?? false) {
                        return "Enter valid note title";
                      } else {
                        return null;
                      }
                    },
                  ),
                  CustomInputField(
                    controller: _descriptionController,
                    labelText: "Note description",
                    validator: (value) {
                      if (value?.isEmpty ?? false) {
                        return "Enter valid note description";
                      } else {
                        return null;
                      }
                    },
                  ),
                  CustomInputField(
                    controller: _sectionController,
                    labelText: "Note section",
                    validator: (value) {
                      if (value?.isEmpty ?? false) {
                        return "Enter valid note section";
                      } else {
                        return null;
                      }
                    },
                  ),
                  CustomInputField(
                    controller: _referencesController,
                    labelText: "Note reference",
                    validator: (value) {
                      if (value?.isEmpty ?? false) {
                        return "Enter valid note reference";
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            ),
            Divider(),
            const Text(
              'Upload Note Image , for better understanding and quick revision',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            CustomButton(
              text: "Upload Image",
              onPressed: () {
                _pickImage();
              },
            ),
            _selectedImage != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Selected Images",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 150,
                        child: ClipRRect(
                          child: Image.file(
                            File(_selectedImage!.path),
                          ),
                        ),
                      )
                    ],
                  )
                : Text("No image selected"),
            CustomButton(
              text: "Save Note",
              onPressed: () {
                _submintForm(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
