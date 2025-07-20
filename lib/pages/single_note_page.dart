import 'package:flutter/material.dart';
import 'package:study_planner_u6_9/models/note_model.dart';

class SingleNotePage extends StatelessWidget {
  final Note note;
  const SingleNotePage({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [Image.network(note.imageUrl.toString())],
      ),
    );
  }
}
