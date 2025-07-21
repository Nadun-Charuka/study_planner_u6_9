import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:study_planner_u6_9/models/course_model.dart';
import 'package:study_planner_u6_9/models/note_model.dart';
import 'package:study_planner_u6_9/services/database/note_service.dart';
import 'package:study_planner_u6_9/widgets/custom_button.dart';
import 'package:study_planner_u6_9/widgets/custom_input_field.dart';
import 'package:study_planner_u6_9/widgets/custom_snackbar.dart';

class AddNewNotePage extends ConsumerStatefulWidget {
  final Course course;
  const AddNewNotePage({
    super.key,
    required this.course,
  });

  @override
  ConsumerState<AddNewNotePage> createState() => _AddNewNotePageState();
}

class _AddNewNotePageState extends ConsumerState<AddNewNotePage> {
  final _fromKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _sectionController = TextEditingController();
  final TextEditingController _referencesController = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedImage;
  bool _isSaving = false;

  Future<void> _pickImage() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = image;
    });
  }

  void _clearAllFields() {
    _titleController.clear();
    _descriptionController.clear();
    _sectionController.clear();
    _referencesController.clear();
    setState(() {
      _selectedImage = null;
    });
  }

  Future<void> _submitForm(BuildContext context) async {
    if (!mounted) return;
    if (!_fromKey.currentState!.validate()) return;
    _fromKey.currentState!.save();

    setState(() => _isSaving = true);

    try {
      await NoteService(courseId: widget.course.id).createNote(
        Note(
          id: "",
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          section: _sectionController.text.trim(),
          reference: _referencesController.text.trim(),
        ),
        _selectedImage != null ? File(_selectedImage!.path) : null,
      );

      if (context.mounted) showSnackBar(context, "Note saved successfully");
      _clearAllFields();
    } catch (e) {
      if (context.mounted) showSnackBar(context, "Error saving note: $e");
    } finally {
      if (mounted) setState(() => _isSaving = false);
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
      body: _isSaving
          ? const Center(
              child: Column(
                spacing: 50,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Image uploading dont go back"),
                  CircularProgressIndicator(),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Add New Note For Your Course',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Fill in the details below to add a new note. And start managing your study planner.',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  Form(
                    key: _fromKey,
                    child: Column(
                      spacing: 10,
                      children: [
                        CustomInputField(
                          controller: _titleController,
                          labelText: "Note Title",
                          validator: (value) => (value?.isEmpty ?? true)
                              ? "Enter valid note title"
                              : null,
                        ),
                        CustomInputField(
                          controller: _descriptionController,
                          labelText: "Note Description",
                          validator: (value) => (value?.isEmpty ?? true)
                              ? "Enter valid note description"
                              : null,
                        ),
                        CustomInputField(
                          controller: _sectionController,
                          labelText: "Note Section",
                          validator: (value) => (value?.isEmpty ?? true)
                              ? "Enter valid note section"
                              : null,
                        ),
                        CustomInputField(
                          controller: _referencesController,
                          labelText: "Note Reference",
                          validator: (value) => (value?.isEmpty ?? true)
                              ? "Enter valid note reference"
                              : null,
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  const Text(
                    'Upload Note Image for better understanding and quick revision',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  CustomButton(
                    text: "Upload Image",
                    onPressed: _pickImage,
                  ),
                  if (_selectedImage != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Selected Image",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 150,
                          child: ClipRRect(
                            child: Image.file(File(_selectedImage!.path)),
                          ),
                        ),
                      ],
                    )
                  else
                    const Text("No image selected"),
                  CustomButton(
                    text: "Save Note",
                    onPressed: () => _submitForm(context),
                  ),
                ],
              ),
            ),
    );
  }
}
