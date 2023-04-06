import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'main.dart';

Future<String> postRequest(email) async {
  var url = 'http://127.0.0.1:8000/api/login';
  Map data = {"email": email};
  //encode Map to JSON
  var body = json.encode(data);

  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: body
  );
     return response.body;
}


class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();

}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RegExp emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  String _email = '';
  String _res = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: getAppBar(),
            body: Center(
                child: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(children: [
        const SizedBox(
          height: 16.0,
        ),
        Image.asset(
          'assets/logo.png',
          width: 150,
          height: 150,
        ),
        const SizedBox(
          height: 40.0,
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                'Connexion',
                style: TextStyle(color: Colors.white, fontSize: 34),
              ),
              const SizedBox(
                height: 40.0,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        'Saisissez votre adresse mail',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: TextFormField(
                          onChanged: (value) => setState(() => _email = value),
                          validator: (value) =>
                              // ignore: unrelated_type_equality_checks
                              value!.isEmpty || !emailRegex.hasMatch(value)
                                  ? 'Veuillez rentrer une adresse mail valide'
                                  : null,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Ex: john.doe@gmail.com",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            String res = await postRequest(_email);
                            setState(() {
                              _res = res;
                            });
                            if (_res == '"Email envoyer"') {
                              print(_res);
                              Navigator.pushNamed(context, '/second');
                            } else if (_res ==
                                '"Cette adresse email ne correspond a aucun compte"') {
                              print(_res);
                              setState(() {
                                _res =
                                    "Cette adresse email ne correspond a aucun compte";
                              });
                            }
                          }
                        },
                        child: const Text('Se connecter'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                            style: TextStyle(
                              color: Colors.red,
                            ),
                            _res),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ))
            ],
          ),
        )
      ]),
    ))));
  }
}
