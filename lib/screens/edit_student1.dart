import 'dart:io';
import 'dart:typed_data';
import 'package:db/db/functions/db_functions.dart';
import 'package:db/db/model/student_model.dart';
import 'package:db/screens/student_list.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditStudent1 extends StatefulWidget {
  final StudentModel student;
  const EditStudent1(int? id, {super.key, required this.student});

  @override
  State<EditStudent1> createState() => _EditStudent1();
}

class _EditStudent1 extends State<EditStudent1> {
  // image
  File? image;
  Uint8List? img1;
  void initState() {
    super.initState();
    // Initialize text controllers with current student data
    _nameController.text = widget.student.name!;
    _ageController.text = widget.student.age.toString();
    _domainController.text = widget.student.domain!;
    _contactController.text = widget.student.contact!;
    img1 = widget.student.profilepic;
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        img1 = File(pickedFile.path).readAsBytesSync();
      }
    });
  }

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _domainController = TextEditingController();
  final _contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EDIT STUDENT'),
        centerTitle: true,
        backgroundColor: Colors.yellowAccent[400],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            child: Center(
              child:
                  // image

                  Column(children: [
                GestureDetector(
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Select Image'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ListTile(
                                leading: const Icon(Icons.photo_library),
                                title: const Text('From Gallery'),
                                onTap: () {
                                  _pickImage(ImageSource.gallery);
                                  Navigator.of(context).pop();
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.camera_alt),
                                title: const Text('From Camera'),
                                onTap: () {
                                  _pickImage(ImageSource.camera);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 30.0),
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: img1 != null
                          ? ClipOval(
                              child: Image.memory(
                              img1!,
                              fit: BoxFit.cover,
                            ))
                          : const Icon(
                              Icons.add_a_photo,
                              size: 40,
                            ),
                    ),
                  ),
                ),

                // NAME
                Column(
                  children: [
                    TextFormField(
                      // validator: (value) {
                      //   if (value == null && value!.isEmpty) {
                      //     return 'fill all the column ';
                      //   } else {
                      //     return null;
                      //   }
                      // },
                      controller: _nameController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          labelText: 'Name',
                          hintText: 'ENTER NAME'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                //AGE
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _ageController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      labelText: 'Age',
                      hintText: 'ENTER AGE'),
                ),
                const SizedBox(
                  height: 30,
                ),
                // domain
                TextFormField(
                  controller: _domainController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      labelText: 'Domain',
                      hintText: 'ENTER DOMAIN'),
                ),
                const SizedBox(
                  height: 30,
                ),
                // CONTACT
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _contactController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      labelText: 'Contact',
                      hintText: 'ENTER CONTACT'),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        child: const Text('Save'),
                        onPressed: () async {
                          final name2 = _nameController.text;
                          final age2 = _ageController.text;
                          final domain2 = _domainController.text;
                          final contact2 = _contactController.text;
                          if (name2.isEmpty ||
                              age2.isEmpty ||
                              domain2.isEmpty ||
                              contact2.isEmpty ||
                              img1 == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('All fields are required!')),
                            );
                          } else {
                            final value = StudentModel(
                              id: widget.student.id,
                              name: name2,
                              age: age2,
                              domain: domain2,
                              contact: contact2,
                              profilepic: img1,
                            );
                            // ignore: unrelated_type_equality_checks
                            if (value != 0) {
                              //  int? id1 = value.id;
                              updateStudent(value, widget.student.id!);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Data saved successfully')),
                              );
                              Navigator.of(context).pop(MaterialPageRoute(
                                  builder: (context) => const StudentList()));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Failed to save data')),
                              );
                            }
                          }
                        }),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            // image = null;
                            img1 = null;
                            _nameController.text = '';
                            _ageController.text = '';
                            _domainController.text = '';
                            _contactController.text = '';
                          });
                        },
                        child: const Text('Clear'))
                  ],
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
