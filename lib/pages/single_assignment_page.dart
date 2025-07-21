import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:study_planner_u6_9/models/assignment_model.dart';

class SingleAssignmentPage extends StatelessWidget {
  final Assignment assignment;
  const SingleAssignmentPage({super.key, required this.assignment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(assignment.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: ${assignment.name}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Description:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              assignment.description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Due Date:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              DateFormat("yyyy-MM-dd").format(assignment.dueDateTime),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Time:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              DateFormat("hh:mm a").format(assignment.dueDateTime),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 40),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
