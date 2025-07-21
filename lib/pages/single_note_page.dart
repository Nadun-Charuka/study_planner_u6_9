import 'package:flutter/material.dart';
import 'package:study_planner_u6_9/models/note_model.dart';

class SingleNotePage extends StatelessWidget {
  final Note note;
  const SingleNotePage({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text(
              'Title: ${note.title}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Description:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              note.description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const Text(
              'Section Name:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              note.section,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const Text(
              'References Books:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              note.reference,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const Divider(),
            const Text(
              'Your Note Images',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            note.imageUrl != null
                ? Image.network(
                    width: 200,
                    note.imageUrl.toString(),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  )
                : Text("No note Images"),
          ],
        ),
      ),
    );
  }
}
