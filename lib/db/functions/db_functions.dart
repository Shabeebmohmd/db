import 'package:db/db/model/student_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);
late Database _db;
Future<void> initialDataBase() async {
  _db = await openDatabase(
    'students.db',
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE students (id INTEGER PRIMARY KEY, name TEXT, age INTEGER, domain TEXT, contact INTEGER, profilepic BLOB)');
    },
  );
}
// add student

Future<void> addStudent(StudentModel value) async {
  print(value);
  await _db.rawInsert(
      'INSERT INTO students(name,age,domain,contact,profilepic)VALUES(?,?,?,?,?)',
      [value.name, value.age, value.domain, value.contact, value.profilepic]);
  await getStudents();
}

// getallstudent

Future<void> getStudents() async {
  // final List<Map<String, dynamic>> students =
  //     await _db.rawQuery('SELECT * FROM students');

  // studentListNotifier.value =
  //     students.map((e) => StudentModel.fromMap(e)).toList();
  // print(students);
  try {
    final List<Map<String, Object?>> val =
        await _db.rawQuery('SELECT * FROM students');
    print('Students fetched: $val');
    studentListNotifier.value.clear();
    for (var map in val) {
      final student = StudentModel.fromMap(map);
      studentListNotifier.value.add(student);
    }
    studentListNotifier.notifyListeners();
  } catch (e) {
    print('Error fetching students: $e');
  }
}

Future<List<Map<String, Object?>>> updateStudent(
    StudentModel value, int id) async {
  print(value);
  final result = await _db.rawQuery(
      'UPDATE students SET name = ?, age = ?, domain=?, contact=?, profilepic=? WHERE id = ?',
      [
        value.name,
        value.age,
        value.domain,
        value.contact,
        value.profilepic,
        value.id
      ]);
  await getStudents();
  return result;
}

// deletestudent

Future<void> deleteStudent(int id) async {
  await _db.rawDelete('DELETE FROM students WHERE id = ?', [id]);
  await getStudents();
}
