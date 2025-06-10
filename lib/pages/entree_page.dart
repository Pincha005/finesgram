import 'package:flutter/material.dart';
import 'inscription_page.dart';

class EntreePage extends StatelessWidget {
  const EntreePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
    );
  }
}
