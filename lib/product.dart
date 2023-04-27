import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:namer_app/main.dart';
import 'fiche.dart';
import 'main.dart';

List<Machine> welcomeFromJson(String str) =>
    List<Machine>.from(json.decode(str).map((x) => Machine.fromJson(x)));

String welcomeToJson(List<Machine> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Future<List<Machine>> fetchMachines() async {
  final response = await http.get(Uri.parse('http://192.168.1.21:8000/api/products/'));

  final machines = welcomeFromJson(response.body);



  // Retourne la liste de machines
  return machines;
}
class Machine {
  Machine({
    required this.createdAt,
    required this.name,
    required this.details,
    required this.stock,
    required this.id,
  });

  DateTime createdAt;
  String name;
  Details details;
  int stock;
  String id;

  factory Machine.fromJson(Map<String, dynamic> json) => Machine(
        createdAt: DateTime.parse(json["createdAt"]),
        name: json["name"],
        details: Details.fromJson(json["details"]),
        stock: json["stock"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "name": name,
        "details": details.toJson(),
        "stock": stock,
        "id": id,
      };
}

class Details {
  Details({
    required this.price,
    required this.description,
    required this.color,
  });

  String price;
  String description;
  String color;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        price: json["price"],
        description: json["description"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "price": price,
        "description": description,
        "color": color,
      };
}

class MachineScreen extends StatefulWidget {
  const MachineScreen({Key? key});

  @override
  State<MachineScreen> createState() => _MachineScreenState();
}

class _MachineScreenState extends State<MachineScreen> {
  late Future<List<Machine>> futureMachines;

  @override
  void initState() {
    super.initState();
    futureMachines = fetchMachines();
  }

  @override
Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    
    home: Scaffold(
      appBar: getAppBar(),
      body: Padding(
        padding: EdgeInsets.all(15.0), // Ajoute de l'écart à l'extérieur des cartes
        child: Center(
          child: FutureBuilder<List<Machine>>(
            future: futureMachines,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // Affiche la liste des noms de machines
                return ListView.separated(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white, // Couleur de fond de la carte
                      elevation: 4.0, // Ombre de la carte
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0), // Bordure arrondie de la carte
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: ListTile(
                          onTap: () {
                        Navigator.push(
                                  context,
                        MaterialPageRoute(
                          builder: (context) => ProductPage(machine: snapshot.data![index]), // Remplacez ProductPage par le nom de la classe de votre page de présentation du produit
                          ),
                                );
                                      },
                          title: Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              snapshot.data![index].name,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8.0), // Ajoute un écart entre le titre et le prix
                              Text(
                                '${snapshot.data![index].details.price} €',
                                style: TextStyle(fontSize: 16.0, color: Colors.black87),
                              ),
                              SizedBox(height: 8.0), // Ajoute un écart entre le prix et la description
                              Text(
                                snapshot.data![index].details.description,
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 14.0, color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(height: 16.0), // Ajoute du padding vertical entre les cartes
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // Par défaut, affiche un spinner de chargement.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    ));
  }
}