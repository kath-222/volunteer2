
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volunteerfind/pages/signupPage.dart';

import 'login.dart';

class SignupOrgPage extends StatefulWidget {
  SignupOrgPage({super.key});

  @override
  _SignupOrgPageState createState() => _SignupOrgPageState();
}

class _SignupOrgPageState extends State<SignupOrgPage> {
  final _formKey = GlobalKey<FormState>();
  String _orgName = '';
  String _username = '';
  String _password = '';
  String _licenseNumber = '';
  String _baseLocation = '';
  int _phoneNumber = 0;
  String _email = '';
  String _field = '';
  String _description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organization Sign Up'),
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Organization Name',
                  ),
                  validator:
                      (value) =>
                  value == null || value.isEmpty
                      ? 'Please enter the organization name'
                      : null,
                  onSaved: (value) => _orgName = value!,
                  maxLength: 50,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Username'),
                  validator:
                      (value) =>
                  value == null || value.isEmpty
                      ? 'Please enter a username'
                      : null,
                  onSaved: (value) => _username = value!,
                  maxLength: 30,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator:
                      (value) =>
                  value == null || value.isEmpty
                      ? 'Please enter a password'
                      : null,
                  onSaved: (value) => _password = value!,
                  obscureText: true,
                  maxLength: 30,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'License Number',
                  ),
                  validator:
                      (value) =>
                  value == null || value.isEmpty
                      ? 'Please enter the license number'
                      : null,
                  onSaved: (value) => _licenseNumber = value!,
                  maxLength: 30,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Base Location'),
                  validator:
                      (value) =>
                  value == null || value.isEmpty
                      ? 'Please enter the base location'
                      : null,
                  onSaved: (value) => _baseLocation = value!,
                  maxLength: 50,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a phone number';
                    } else if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  onSaved: (value) => _phoneNumber = int.parse(value!),
                  keyboardType: TextInputType.phone,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    } else if (!RegExp(
                      r'^[^@]+@[^@]+\.[^@]+',
                    ).hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onSaved: (value) => _email = value!,
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Field (e.g. Education, Health)',
                  ),
                  validator:
                      (value) =>
                  value == null || value.isEmpty
                      ? 'Please enter the organization field'
                      : null,
                  onSaved: (value) => _field = value!,
                  maxLength: 50,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Description (Optional)',
                  ),
                  onSaved: (value) => _description = value ?? '',
                  maxLines: 3,
                  maxLength: 200,
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Submitted Information'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: [
                                  Text('Organization Name: $_orgName'),
                                  Text('Username: $_username'),
                                  Text('Password: $_password'),
                                  Text('License Number: $_licenseNumber'),
                                  Text('Base Location: $_baseLocation'),
                                  Text('Phone Number: $_phoneNumber'),
                                  Text('Email: $_email'),
                                  Text('Field: $_field'),
                                  Text('Description: $_description'),
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
                          );
                        },
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
