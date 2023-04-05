import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<String> postRequest (email) async {
  var url ='http://127.0.0.1:8000/api/login';
  Map data = {
    "email" : email
  };
  //encode Map to JSON
  var body = json.encode(data);

  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: body
  );
  


  String res = "${response.body}";
  if(res == '"Email envoyer"'){
    return "test";
  } 
  return response.body;
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}




class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RegExp emailRegex = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  String _email = '';
  

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
              key: _formKey,
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
                  onChanged: (value) => setState(() => _email = value),
                  validator: (value) => 
                    value!.isEmpty || !emailRegex.hasMatch(value)
                    ? 'Please enter a valid email'
                    : null,
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
                  onPressed: () async {
                    if(_formKey.currentState!.validate()) {      
                      String res = await postRequest(_email);          
                      if ("${res}" == "test"){
                        Navigator.pushNamed(context, '/second');
                      }
                    }
                  },
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
