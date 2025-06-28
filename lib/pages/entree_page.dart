import 'package:flutter/material.dart';
import 'inscription_page.dart';

class EntreePage extends StatelessWidget {
  const EntreePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 248, 249),
      appBar: AppBar(
        title: const Text(
          'Bienvenue au Finesgram',
          style: TextStyle(color: Color.fromARGB(255, 255, 254, 254)),
        ),
        backgroundColor: const Color.fromARGB(255, 107, 171, 232),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo3.png', width: 200),
            const Text(
              'Gérer vos finances cher étudiant',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 133, 179, 234),
              ),
            ),
            const SizedBox(height: 30), // espacement
            ElevatedButton(
              onPressed: () => _navigateToInscription(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 221, 164, 205),
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
