import 'package:db/db/functions/db_functions.dart';
// import 'package:db/screens/add_student.dart';
import 'package:db/screens/student_List.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialDataBase();
  runApp(DbApp());
}

class DbApp extends StatelessWidget {
  const DbApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: StudentList(),
    );
  }
}
