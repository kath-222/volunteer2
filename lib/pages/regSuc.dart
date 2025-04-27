
import 'package:flutter/material.dart';

import 'MyHomePage.dart';
import 'login.dart';

class regSuc extends StatefulWidget {
  const regSuc({super.key});
  @override
  State<regSuc> createState() => _regSuc();
}

class _regSuc extends State<regSuc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signed up Successfully!'),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            Text('Registration Successful!'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: Text('Log in'),
            ),
          ],
        ),
      ),
    );
  }
}
