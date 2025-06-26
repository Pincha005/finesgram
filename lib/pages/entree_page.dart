import 'package:flutter/material.dart';
import 'inscription_page.dart';

class EntreePage extends StatelessWidget {
  const EntreePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 183, 163, 104),
      appBar: AppBar(
        title: const Text(
          'Bienvenue au Finesgram',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.brown[700],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo2.png', width: 200),
            const Text(
              'Gérer vos finances cher étudiant',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30), // espacement
            ElevatedButton(
              onPressed: () => _navigateToInscription(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[600],
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text(
                'Commencer l\'inscription',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToInscription(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const InscriptionPage()),
    );
  }
}
