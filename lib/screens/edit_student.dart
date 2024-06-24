import 'package:db/db/model/student_model.dart';
import 'package:flutter/material.dart';

class EditStudent extends StatefulWidget {
  final StudentModel student;

  const EditStudent(int? id, {super.key, required this.student});

  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EDIT STUDENT'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
    );
  }
}
