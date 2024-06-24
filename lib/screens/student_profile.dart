// import 'dart:typed_data';

import 'package:db/db/model/student_model.dart';
import 'package:flutter/material.dart';

class StudentProfile extends StatefulWidget {
  final StudentModel student;
  const StudentProfile(int? id, {super.key, required this.student});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('STUDENT PROFILE'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 223, 97, 97),
      ),
      body: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: widget.student.profilepic != null
                ? MemoryImage(widget.student.profilepic!)
                : null,
            child: widget.student.profilepic == null
                ? const Icon(Icons.person)
                : null,
          ),
          // name
          Card(
            color: const Color.fromARGB(255, 164, 186, 197),
            shadowColor: Colors.grey,
            child: ListTile(
              title: Align(
                alignment: Alignment.center,
                child: Text(
                  'Name: ${widget.student.name.toString()}',
                  style: const TextStyle(fontSize: 30),
                ),
              ),
            ),
          ),
          // age
          Card(
            color: const Color.fromARGB(255, 164, 186, 197),
            shadowColor: Colors.grey,
            child: ListTile(
              title: Align(
                alignment: Alignment.center,
                child: Text(
                  'Age: ${widget.student.age.toString()}',
                  style: const TextStyle(fontSize: 23),
                ),
              ),
            ),
          ),
          //DOMAIN
          Card(
            color: const Color.fromARGB(255, 164, 186, 197),
            shadowColor: Colors.grey,
            child: ListTile(
              title: Align(
                alignment: Alignment.center,
                child: Text(
                  'Domain: ${widget.student.domain.toString()}',
                  style: const TextStyle(fontSize: 23),
                ),
              ),
            ),
          ),
          // contact
          Card(
            color: const Color.fromARGB(255, 164, 186, 197),
            shadowColor: Colors.grey,
            child: ListTile(
              title: Align(
                alignment: Alignment.center,
                child: Text(
                  'Contact: ${widget.student.contact.toString()}',
                  style: const TextStyle(fontSize: 23),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
