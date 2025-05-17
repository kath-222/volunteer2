import 'package:flutter/material.dart';
import 'package:volunteerfind/theme/theme_const.dart';

import 'pages/MyHomePage.dart';
import 'package:firebase_core/firebase_core.dart';

enum UserType { volunteer, organization }

UserType? currentUserType;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: defaultTheme,

      home: const MyHomePage(title: 'Flutter Demo Home Page', username: '',),
    );
  }
}

