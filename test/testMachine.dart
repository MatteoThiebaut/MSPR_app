import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:namer_app/fiche.dart';
import 'package:namer_app/ProductARPage.dart';
import 'package:namer_app/product.dart';

// Mock de ArCoreController pour les tests
class MockArCoreController extends Mock implements ArCoreController {}

void main() {
  group('ProductPage tests', () {
    testWidgets('ProductPage renders correctly', (WidgetTester tester) async {
      final machine = Machine(
        createdAt: DateTime.now(),
        name: 'Test Machine',
        details: Details(
          price: '100',
          description: 'Test Description',
          color: 'Red',
        ),
        stock: 10,
        id: '1',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: ProductPage(machine: machine),
        ),
      );

      expect(find.text(machine.name), findsOneWidget);
      expect(find.text('Price: ${machine.details.price} €'), findsOneWidget);
      expect(find.text('Description: ${machine.details.description}'),
          findsOneWidget);
      expect(find.text('Color : ${machine.details.color}'), findsOneWidget);
      expect(find.text('Activer AR'), findsOneWidget);
      expect(find.byType(ProductARPage), findsNothing);
    });

    testWidgets('Tapping AR button enables/disables AR',
        (WidgetTester tester) async {
      final machine = Machine(
        createdAt: DateTime.now(),
        name: 'Test Machine',
        details: Details(
          price: '100',
          description: 'Test Description',
          color: 'Red',
        ),
        stock: 10,
        id: '1',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: ProductPage(machine: machine),
        ),
      );

      // Activer AR
      await tester.tap(find.text('Activer AR'));
      await tester.pump();

      expect(find.text('Désactiver AR'), findsOneWidget);
      expect(find.byType(ProductARPage), findsOneWidget);

      // Désactiver AR
      await tester.tap(find.text('Désactiver AR'));
      await tester.pump();

      expect(find.text('Activer AR'), findsOneWidget);
      expect(find.byType(ProductARPage), findsNothing);
    });
  });

  group('ProductARPage tests', () {
    testWidgets('ProductARPage renders correctly', (WidgetTester tester) async {
      final arCoreController = MockArCoreController();

      await tester.pumpWidget(
        MaterialApp(
          home: ProductARPage(),
        ),
      );

      expect(find.byType(ArCoreView), findsOneWidget);

      await tester.runAsync(() async {
        await tester.pump(Duration.zero);

        final arCoreViewFinder = find.byType(ArCoreView);
        expect(arCoreViewFinder, findsOneWidget);

        final arCoreViewWidget = tester.widget<ArCoreView>(arCoreViewFinder);
        arCoreViewWidget.onArCoreViewCreated(arCoreController);

        verify(arCoreController.onPlaneTap).called(1);
      });
    });
  });

  group('Machine tests', () {
    test('Machine can be created from JSON', () {
      final machineJson = {
        "createdAt": "2023-06-01T12:00:00Z",
        "name": "Test Machine",
        "details": {
          "price": "100",
          "description": "Test Description",
          "color": "Red"
        },
        "stock": 10,
        "id": "1"
      };

      final machine = Machine.fromJson(machineJson);

      expect(machine.createdAt, DateTime.parse('2023-06-01T12:00:00Z'));
      expect(machine.name, 'Test Machine');
      expect(machine.details.price, '100');
      expect(machine.details.description, 'Test Description');
      expect(machine.details.color, 'Red');
      expect(machine.stock, 10);
      expect(machine.id, '1');
    });

    test('Machine can be converted to JSON', () {
      final machine = Machine(
        createdAt: DateTime.parse('2023-06-01T12:00:00Z'),
        name: 'Test Machine',
        details: Details(
          price: '100',
          description: 'Test Description',
          color: 'Red',
        ),
        stock: 10,
        id: '1',
      );

      final machineJson = machine.toJson();

      expect(machineJson['createdAt'], '2023-06-01T12:00:00Z');
      expect(machineJson['name'], 'Test Machine');
      expect(machineJson['details']['price'], '100');
      expect(machineJson['details']['description'], 'Test Description');
      expect(machineJson['details']['color'], 'Red');
      expect(machineJson['stock'], 10);
      expect(machineJson['id'], '1');
    });
  });

  group('MachineScreen tests', () {
    testWidgets('Machines are fetched and displayed correctly',
        (WidgetTester tester) async {
      final machines = [
        Machine(
          createdAt: DateTime.parse('2023-06-01T12:00:00Z'),
          name: 'Test Machine 1',
          details: Details(
            price: '100',
            description: 'Test Description 1',
            color: 'Red',
          ),
          stock: 10,
          id: '1',
        ),
        Machine(
          createdAt: DateTime.parse('2023-06-02T12:00:00Z'),
          name: 'Test Machine 2',
          details: Details(
            price: '200',
            description: 'Test Description 2',
            color: 'Blue',
          ),
          stock: 5,
          id: '2',
        ),
      ];

      // @todo Mock de l'API de récupération des machiness

      await tester.pump();

      expect(find.text('Test Machine 1'), findsOneWidget);
      expect(find.text('Price: 100 €'), findsOneWidget);
      expect(find.text('Description: Test Description 1'), findsOneWidget);
      expect(find.text('Color: Red'), findsOneWidget);
      expect(find.text('Stock: 10'), findsOneWidget);

      expect(find.text('Test Machine 2'), findsOneWidget);
      expect(find.text('Price: 200 €'), findsOneWidget);
      expect(find.text('Description: Test Description 2'), findsOneWidget);
      expect(find.text('Color: Blue'), findsOneWidget);
      expect(find.text('Stock: 5'), findsOneWidget);
    });
  });
}
