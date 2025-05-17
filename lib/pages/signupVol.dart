
import 'package:flutter/material.dart';
import 'package:volunteerfind/models/volunteer.dart';
import 'package:volunteerfind/pages/signupPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';

class SignupVolPage extends StatefulWidget {
  SignupVolPage({super.key});

  @override
  _SignupVolPageState createState() => _SignupVolPageState();
}

class _SignupVolPageState extends State<SignupVolPage> {
  final _formKeyx = GlobalKey<FormState>();
  String _fname = '';
  String _lname = '';
  String _username = '';
  String _password = '';
  DateTime? _birthdate;
  String _gender = '';
  int _phone = 0;
  String _location = '';
  String _qualifications = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Volunteer Sign Up'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: () {
              // Handle
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignupPage()),
            );
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Form(
            key: _formKeyx,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'First Name'),
                        validator:
                            (value) =>
                        value == null || value.isEmpty
                            ? 'Please enter a first name'
                            : null,
                        onSaved: (value) => _fname = value!,
                        maxLength: 30,
                      ),
                    ),
                    SizedBox(width: 10),

                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Last Name'),
                        validator:
                            (value) =>
                        value == null || value.isEmpty
                            ? 'Please enter a first name'
                            : null,
                        onSaved: (value) => _lname = value!,
                        maxLength: 30,
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Username'),
                  validator:
                      (value) =>
                  value == null || value.isEmpty
                      ? 'Please enter a user name'
                      : null,
                  onSaved: (value) => _username = value!,
                  maxLength: 30,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  validator:
                      (value) =>
                  value == null || value.isEmpty
                      ? 'Please enter a password name'
                      : null,
                  onSaved: (value) => _password = value!,
                  maxLength: 30,
                  obscureText: true,
                ),
                //date picker
                TextButton(
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      setState(() {
                        _birthdate = picked;
                      });
                    }
                  },
                  child: Text(
                    _birthdate == null
                        ? 'Select Birthdate'
                        : 'Birthdate: ${_birthdate?.toLocal()}'.split(' ')[0],
                  ),
                ),

                //gender dropdown
                DropdownButtonFormField(
                  items: [
                    DropdownMenuItem(child: Text('Male'), value: 'M'),
                    DropdownMenuItem(child: Text('Female'), value: 'F'),
                  ],
                  decoration: InputDecoration(label: Text('Gender')),
                  onChanged: (value) {
                    setState(() {
                      _gender = value!;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Location'),
                  onSaved: (value) => _location = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Qualifications'),
                  onSaved: (value) => _qualifications = value!,
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKeyx.currentState!.validate() &&
                        _birthdate != null) {
                      _formKeyx.currentState!.save();

                      //Make new Volunteer
                      final newVol = Volunteer(
                          _fname,
                          _lname,
                          _username,
                          _password
                      );

                      // Write Volunteer into collection
                      await FirebaseFirestore.instance
                          .collection('Volunteer')
                          .add(newVol.toMap());



                      //Show success in snakbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Signed up successfully!')),
                      );

                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                          title: Text('Submitted Information'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: [
                                Text('First Name: $_fname'),
                                Text('Last Name: $_lname'),
                                Text('Username: $_username'),
                                Text('Password: $_password'),
                                Text(
                                  'Birthdate: ${_birthdate?.toLocal().toString().split(' ')[0]}',
                                ),
                                Text('Gender: $_gender'),
                                Text('Location: $_location'),
                                Text('Qualifications: $_qualifications'),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                );
                              },
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );


                    } else {
                      if (_birthdate == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please select your birthdate'),
                          ),
                        );
                      }
                    }
                  },

                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
