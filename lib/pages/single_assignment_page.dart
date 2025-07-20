import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SingleAssignmentPage extends ConsumerStatefulWidget {
  const SingleAssignmentPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SingleAssignmentPageState();
}

class _SingleAssignmentPageState extends ConsumerState<SingleAssignmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
