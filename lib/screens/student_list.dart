import 'package:db/db/functions/db_functions.dart';
import 'package:db/db/model/student_model.dart';
import 'package:db/screens/add_student.dart';
import 'package:db/screens/edit_student1.dart';
import 'package:db/screens/student_profile.dart';
import 'package:flutter/material.dart';

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  bool isGridView =
      false; // State variable to toggle between list and grid views
  final TextEditingController searchController = TextEditingController();
  List<StudentModel> filteredStudents = [];

  @override
  void initState() {
    super.initState();
    getStudents();
    searchController.addListener(_filterStudents);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _filterStudents() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredStudents = studentListNotifier.value
          .where((student) => student.name!.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[300],
        title: const Text('STUDENT LIST'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.list : Icons.grid_view),
            onPressed: () {
              setState(() {
                isGridView = !isGridView;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search here',
                filled: true,
                fillColor: const Color.fromARGB(255, 236, 237, 237),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: studentListNotifier,
              builder: (context, List<StudentModel> students, child) {
                if (searchController.text.isEmpty) {
                  filteredStudents = students;
                }

                if (filteredStudents.isEmpty) {
                  return const Center(child: Text('No students found.'));
                }

                if (isGridView) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    ),
                    itemCount: filteredStudents.length,
                    itemBuilder: (context, index) {
                      final student = filteredStudents[index];
                      return buildGridStudentCard(context, student);
                    },
                  );
                } else {
                  return ListView.builder(
                    itemCount: filteredStudents.length,
                    itemBuilder: (context, index) {
                      final student = filteredStudents[index];
                      return buildListStudentCard(context, student);
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Addstudent(),
                      ),
                    );
                  },
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListStudentCard(BuildContext context, StudentModel student) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
            return StudentProfile(student.id, student: student);
          }));
        },
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 40,
            backgroundImage: student.profilepic != null
                ? MemoryImage(student.profilepic!)
                : null,
            child: student.profilepic == null ? const Icon(Icons.person) : null,
          ),
        ),
        subtitle: Column(
          children: [
            Text(
              student.name.toString(),
              style: const TextStyle(fontSize: 25),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: const Text("Delete!!"),
                            content:
                                const Text('Are you sure you want to Delete?'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    if (student.id != null) {
                                      deleteStudent(student.id!.toInt());
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Student ID is null'),
                                        ),
                                      );
                                    }
                                  },
                                  child: const Text('Confirm'))
                            ]);
                      });
                },
                icon: const Icon(Icons.delete)),
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return EditStudent1(
                      student.id,
                      student: student,
                    );
                  }));
                },
                icon: const Icon(Icons.edit)),
          ],
        ),
      ),
    );
  }

  Widget buildGridStudentCard(BuildContext context, StudentModel student) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
            return StudentProfile(student.id, student: student);
          }));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: student.profilepic != null
                  ? MemoryImage(student.profilepic!)
                  : null,
              child:
                  student.profilepic == null ? const Icon(Icons.person) : null,
            ),
            const SizedBox(height: 8),
            Text(
              student.name.toString(),
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
