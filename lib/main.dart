import 'package:flutter/material.dart';
import 'Auth.dart';
import 'Qrcode.dart';

final Color primaryColor = Color(0xFF3F2E00);
final Color secondaryColor = Color(0x9C93763F);
final Color tertiaryColor = Color(0xFFC8B576);
final Color background = Color(0xFFD0D0D0);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/product',
        routes: {
          '/': (context) => const AuthScreen(),
          '/second': (context) => const qrCodeScreen(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: secondaryColor,
          ),
          scaffoldBackgroundColor: background,
          textTheme: TextTheme(
            bodyMedium: TextStyle(color: primaryColor),
          ),
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Paye ton Kawa',
                style: TextStyle(color: primaryColor, fontFamily: 'Satisfy'),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
              ),
              Image.asset(
                'assets/lologo.png',
                fit: BoxFit.contain,
                height: 32,
              ),
            ]),
          ),
        ));
  }
}
