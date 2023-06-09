import 'package:flutter/material.dart';
import 'product.dart';
import 'main.dart';
import 'productARPage.dart';

class ProductPage extends StatefulWidget {
  final Machine machine;

  const ProductPage({Key? key, required this.machine}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool isArEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.machine.name,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Price: ${widget.machine.details.price} €',
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 40.0),
            Text(
              'Description: ${widget.machine.details.description}',
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Color : ${widget.machine.details.color}',
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isArEnabled = !isArEnabled;
                });
              },
              child: Text(isArEnabled ? "Désactiver AR" : "Activer AR"),
            ),
            SizedBox(height: 20),
            Expanded(
              child: isArEnabled ? ProductARPage() : Container(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
