import 'package:flutter/material.dart';
import 'package:senior_project/ui/login/login-screen.dart';
import 'package:senior_project/ui/login/register-screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
          scaffoldBackgroundColor: Colors.grey.shade50,
      ),
      home: LoginScreen()
    );
  }
}

