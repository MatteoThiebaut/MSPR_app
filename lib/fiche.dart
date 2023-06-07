import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'product.dart';
import 'main.dart';
import 'dart:io';

class ProductPage extends StatefulWidget {
  final Machine machine;

  const ProductPage({Key? key, required this.machine}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  ArCoreController? arCoreController;
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
                if (isArEnabled) {
                  arCoreController?.resume();
                } else {
                  arCoreController?.removeNode(nodeName: 'myImageNode');
                }
              },
              child: Text(isArEnabled ? "Désactiver AR" : "Activer AR"),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ArCoreView(
                onArCoreViewCreated: _onArCoreViewCreated,
                enableTapRecognizer: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController?.onPlaneTap = _handleOnPlaneTap;
  }

 void _handleOnPlaneTap(List<ArCoreHitTestResult> hits) {
  // Récupérez le premier point d'intersection entre le plan et le rayon
  final hit = hits.first;
  
  // Définissez la position de l'image à la position du point d'intersection
  final pose = hit.pose.translation;
  
  
  // Créez un nouveau noeud contenant l'image
  final node = ArCoreReferenceNode(
    name: 'myImageNode',
    objectUrl: 'assets/CokeMachine.glb',
    position: pose,
    rotation: hit.pose.rotation, 
  );
  
  // Ajoutez le noeud à la scène ARCore
  arCoreController?.addArCoreNode(node);
}


  @override
  void dispose() {
    arCoreController?.dispose();
    super.dispose();
  }
}
