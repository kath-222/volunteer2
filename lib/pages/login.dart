

import 'package:flutter/material.dart';
import 'package:volunteerfind/pages/signupPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'MyHomePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  bool isPasswordVisible = false;
  bool _loading = false;

  Future<void> _authenticate() async {
    setState(() => _loading = true);

    // check one collection for matching user/pass
    Future<bool> checkCollection(String name) async {
      final snap = await FirebaseFirestore.instance
          .collection(name)
          .where('username', isEqualTo: username)
          .where('password', isEqualTo: password)
          .limit(1)
          .get();
      return snap.docs.isNotEmpty;
    }

    // first try Volunteer
    bool ok = await checkCollection('Volunteer');

    // if not found, try Organization
    if (!ok) ok = await checkCollection('Organization');

    setState(() => _loading = false);


    if (ok) {
      // success!
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => MyHomePage(
            title: 'Let’s Volunteer!',
            username: username,
          ),
        ),
      );
    } else {
      // failure
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid username or password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {/*
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyHomePage(title: 'Volunteering', username: '',),
              ),
            );*/
          },
        ),
      ),
      body: Center(
        child: _loading
        ? const CircularProgressIndicator()
        :Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Login Page', style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 16.0,
                        ),

                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(3),
                          labelText: 'Username*',
                          border: OutlineInputBorder(),
                        ),
                        validator:
                            (value) =>
                        value == null || value.length < 4
                            ? 'Please enter a valid username'
                            : null,
                        onSaved: (value) {
                          username = value ?? '';
                        },
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        obscureText: isPasswordVisible,
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 16.0,
                        ),

                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(3),
                          labelText: 'Password*',
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        validator:
                            (value) =>
                        value == null || value.length < 6
                            ? 'Please enter a valid password'
                            : null,
                        onSaved: (value) {
                          password = value ?? '';
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: ElevatedButton(
                        child: Text('Login'),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              _authenticate();


                            }
                          }

                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 50, 10, 10),
              child: ElevatedButton(
                onPressed: () {
                  // go to login page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignupPage()),
                  );
                },
                style: ButtonStyle(),
                child: Text('Sign up'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
