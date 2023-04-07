import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'dart:convert';

// ignore: camel_case_types
class qrCodeScreen extends StatefulWidget {
  const qrCodeScreen({super.key});

  @override
  State<qrCodeScreen> createState() => _qrCodeScreenState();
}

// ignore: camel_case_types
class _qrCodeScreenState extends State<qrCodeScreen> {
  var getResult = "Qr Code result";

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
                  const Text(
                    'Scanner le QRCode',
                    style: TextStyle(color: Colors.indigo, fontSize: 34),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.indigo,
                      onPrimary: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/product');
                    },
                    child: const Text('Scan'),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Text(getResult),
                ],
              ))),
    ));
  }

  void scanQRCode() async {
  try {
    final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Annuler', false, ScanMode.BARCODE);

    if (!mounted) return;

    setState(() {
      getResult = qrCode;
    });

    print("QRCode_Result:--");
    print(getResult);

    // Convertir le résultat en JSON
    Map<String, dynamic> qrCodeData = jsonDecode(getResult);
    
    // Extraire l'e-mail du résultat JSON
    String email = qrCodeData['email'];
    
    // Utiliser l'e-mail récupéré pour effectuer les actions nécessaires
    print("Email: $email");

  } on PlatformException {
    getResult = "Erreur lors du scan du QRCode.";
  }
  }
}