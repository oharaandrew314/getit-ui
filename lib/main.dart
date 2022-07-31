import 'package:flutter/material.dart';
import 'package:getit_ui/screens/login_screen.dart';

void main() {
  runApp(MaterialApp(
    title: 'GetIt - Shopping Lists',
    theme: ThemeData(
      primaryColor: Colors.lightBlue,
      fontFamily: 'Roboto',
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold, color: Colors.lightBlue),
        displayMedium: TextStyle(fontSize: 32.0),
      ),
    ),
    home: const LoginScreen(),
  ));
}