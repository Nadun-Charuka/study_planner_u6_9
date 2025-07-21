import 'package:cloud_firestore/cloud_firestore.dart';

class Assignment {
  final String id;
  final String name;
  final String description;
  final String duration;
  final DateTime dueDateTime;

  Assignment({
    required this.id,
    required this.name,
    required this.description,
    required this.duration,
    required this.dueDateTime,
  });

  factory Assignment.fromJson(Map<String, dynamic> json, String docId) {
    return Assignment(
      id: docId,
      name: json['name'],
      description: json['description'],
      duration: json['duration'],
      dueDateTime: (json['dueDateTime'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'duration': duration,
      'dueDateTime': Timestamp.fromDate(dueDateTime),
    };
  }
}
