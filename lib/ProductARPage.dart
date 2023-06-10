import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';

class ProductARPage extends StatefulWidget {
  @override
  _ProductARPageState createState() => _ProductARPageState();
}

class _ProductARPageState extends State<ProductARPage> {
  ArCoreController? arCoreController;

  @override
  Widget build(BuildContext context) {
    return ArCoreView(
      onArCoreViewCreated: _onArCoreViewCreated,
      enableTapRecognizer: true,
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
