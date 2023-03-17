import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/material.dart';

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
                      scanQRCode();
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
      print(qrCode);
    } on PlatformException {
      getResult = "Erreur lors du scan du QRCode.";
    }
  }
}
