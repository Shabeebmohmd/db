import 'dart:io';
import 'dart:typed_data';
import 'package:db/db/functions/db_functions.dart';
import 'package:db/db/model/student_model.dart';
import 'package:db/screens/student_list.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Addstudent extends StatefulWidget {
  const Addstudent({super.key});

  @override
  State<Addstudent> createState() => _AddstudentState();
}

class _AddstudentState extends State<Addstudent> {
  // image
  File? image;
  Uint8List? image1;
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        image1 = File(pickedFile.path).readAsBytesSync();
      }
    });
  }

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _domainController = TextEditingController();
  final _contactController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADD STUDENT'),
        centerTitle: true,
        backgroundColor: Colors.yellowAccent[400],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      child: image != null
                          ? ClipOval(
                              child: Image.file(
                              image!,
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
                      controller: _nameController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          labelText: 'Name',
                          hintText: 'ENTER NAME'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an age';
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a domain';
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a contact';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        child: const Text('Add'),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final name2 = _nameController.text;
                            final age2 = _ageController.text;
                            final domain2 = _domainController.text;
                            final contact2 = _contactController.text;

                            if (image == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Image is required!')),
                              );
                            } else {
                              final value = StudentModel(
                                id: null,
                                name: name2,
                                age: age2,
                                domain: domain2,
                                contact: contact2,
                                profilepic: image1,
                              );
                              addStudent(value);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Data saved successfully')),
                              );
                              Navigator.of(context).pop(MaterialPageRoute(
                                  builder: (context) => const StudentList()));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('All fields are required!')),
                            );
                          }
                        }),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            image = null;
                            image1 = null;
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
