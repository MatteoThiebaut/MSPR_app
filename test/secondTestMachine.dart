import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:namer_app/fiche.dart';
import 'package:namer_app/product.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient httpClient;
  late Machine machine;
  late List<Machine> machines;

  setUp(() {
    httpClient = MockHttpClient();
    machine = Machine(
      createdAt: DateTime.now(),
      name: 'Machine 1',
      details: Details(
        price: '10',
        description: 'Description 1',
        color: 'Red',
      ),
      stock: 5,
      id: '1',
    );
    machines = [machine];
  });

  test('Test converting JSON to Machine object', () {
    // Arrange
    const json = '''
    {
      "createdAt": "2022-01-01T00:00:00Z",
      "name": "Machine 1",
      "details": {
        "price": "10",
        "description": "Description 1",
        "color": "Red"
      },
      "stock": 5,
      "id": "1"
    }
    ''';

    // Act
    final result = Machine.fromJson(jsonDecode(json));

    // Assert
    expect(result.createdAt, DateTime.utc(2022, 1, 1));
    expect(result.name, 'Machine 1');
    expect(result.details.price, '10');
    expect(result.details.description, 'Description 1');
    expect(result.details.color, 'Red');
    expect(result.stock, 5);
    expect(result.id, '1');
  });

  test('Test converting Machine object to JSON', () {
    // Arrange
    final machine = Machine(
      createdAt: DateTime.utc(2022, 1, 1),
      name: 'Machine 1',
      details: Details(
        price: '10',
        description: 'Description 1',
        color: 'Red',
      ),
      stock: 5,
      id: '1',
    );

    // Act
    final result = machine.toJson();

    // Assert
    expect(result['createdAt'], '2022-01-01T00:00:00.000Z');
    expect(result['name'], 'Machine 1');
    expect(result['details']['price'], '10');
    expect(result['details']['description'], 'Description 1');
    expect(result['details']['color'], 'Red');
    expect(result['stock'], 5);
    expect(result['id'], '1');
  });

  testWidgets('Test rendering machine details in MachineScreen',
      (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(
      MaterialApp(
        home: MachineScreen(),
      ),
    );

    // Act
    await tester.pump();

    // Assert
    expect(find.text(machine.name), findsOneWidget);
    expect(find.text(machine.details.price), findsOneWidget);
    expect(find.text(machine.details.description), findsOneWidget);
    expect(find.text(machine.details.color), findsOneWidget);
  });

  testWidgets('Test navigating to ProductPage', (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(
      MaterialApp(
        home: MachineScreen(),
      ),
    );

    // Act
    await tester.tap(find.text(machine.name));
    await tester.pumpAndSettle();

    // Assert
    expect(find.byType(ProductPage), findsOneWidget);
  });
}
