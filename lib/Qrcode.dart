import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'dart:convert';

// ignore: camel_case_types²

// ignore: camel_case_types
class qrCodeScreen extends StatefulWidget {
  const qrCodeScreen({super.key});

  @override
  State<qrCodeScreen> createState() => _qrCodeScreenState();
}

// ignore: camel_case_types
class _qrCodeScreenState extends State<qrCodeScreen> {
  var getResult = "Qr Code result";
  var scannedEmail = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: getAppBar(),
            body: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  children: [
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
                        child: Column(children: [
                          const SizedBox(
                            height: 25.0,
                          ),
                          const Text(
                            'Connexion',
                            style: TextStyle(color: Colors.white, fontSize: 34),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          const Text(
                            'Le formulaire a bien été envoyé !',
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.0),
                            child: Text(
                              'Vous avez reçu un Qrcode par email pour valider votre connexion, scannez-le !',
                              style: TextStyle(color: Colors.white),
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
                            onPressed: () {
                              scanQRCode();
                            },
                            child: const Text('Scan'),
                          ),
                          const SizedBox(
                            height: 25.0,
                          ),
                        ]))
                  ],
                ),
              ),
            )));
  }

  void scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Annuler', false, ScanMode.BARCODE);

      if (!mounted) return;

      setState(() {
        getResult = qrCode;
      });

      // Convertir le résultat en JSON
      Map<String, dynamic> qrCodeData = jsonDecode(getResult);
      String? scannedEmail = qrCodeData['email'];
      // Extraire l'e-mail du résultat JSON

      print("scannedEmail : " + scannedEmail!);
      print("good");
      Navigator.pushNamed(context, '/product');
    } on PlatformException {
      getResult = "Erreur lors du scan du QRCode.";
    }
  }
}
