import 'package:flutter/material.dart';
import 'package:getit_ui/screens/login_screen.dart';

void main() {
  runApp(MaterialApp(
    title: 'GetIt - Shopping Lists',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const LoginScreen(),
  ));
}