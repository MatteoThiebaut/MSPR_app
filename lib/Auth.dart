import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
          child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          children: [
            const Text(
              'Connexion',
              style: TextStyle(color: Colors.indigo, fontSize: 34),
            ),
            const SizedBox(
              height: 50.0,
            ),
            Form(
                child: Column(
              children: [
                const Text(
                  'Saisissez votre adresse mail',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                TextFormField(
                    decoration: InputDecoration(
                  hintText: "Ex: john.doe@gmail.com",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.grey)),
                )),
                const SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigo,
                    onPrimary: Colors.white,
                  ),
                  onPressed: () => print('send'),
                  child: const Text('Se connecter'),
                )
              ],
            ))
          ],
        ),
      )),
    ));
  }
}
