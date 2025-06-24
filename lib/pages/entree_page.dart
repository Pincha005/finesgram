import 'package:flutter/material.dart';
import 'inscription_page.dart';

class EntreePage extends StatelessWidget {
  const EntreePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 183, 163, 104),
      appBar: AppBar(title: const Text('Bienvenu au Finesgram')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const InscriptionPage()),
            );
          },
          child: const Text('Aller à l’inscription'),
        ),
      ),
      // body: Container(color: const Color.fromARGB(255, 4, 55, 44)),
    );
  }
}
