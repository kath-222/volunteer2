

import 'package:flutter/material.dart';
import 'package:volunteerfind/pages/signupPage.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyHomePage(title: 'Volunteering', username: '',),
              ),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
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
                              print('Username: $username and Pass: $password');
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyHomePage(
                                    title: 'Lets Volunteer!',
                                    username: username, // <-- Pass username
                                  ),
                                ),
                              );
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
