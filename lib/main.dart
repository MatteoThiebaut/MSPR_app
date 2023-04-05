import 'package:flutter/material.dart';
import 'Auth.dart';
import 'Qrcode.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
    // When navigating to the "/" route, build the FirstScreen widget.
    '/': (context) => const AuthScreen(),
    // When navigating to the "/second" route, build the SecondScreen widget.
    '/second': (context) => const qrCodeScreen(),
      },  
    );
  }
}