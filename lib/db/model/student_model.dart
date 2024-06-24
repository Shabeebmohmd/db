import 'dart:typed_data';

class StudentModel {
  final int? id;
  final String? name;
  final String? age;
  final String? domain;
  final String? contact;
  Uint8List? profilepic;

  StudentModel({
    required this.id,
    required this.name,
    required this.age,
    required this.domain,
    required this.contact,
    required this.profilepic,
  });
  static StudentModel fromMap(Map<String, Object?> map) {
    final id = map['id'] as int;
    final name = map['name'] as String;
    final age = map['age'].toString();
    final domain = map['domain'].toString();
    final contact = map['contact'].toString();
    final profilepic = map['profilepic'] as Uint8List;

    return StudentModel(
        id: id,
        name: name,
        age: age,
        domain: domain,
        contact: contact,
        profilepic: profilepic);
  }
}
