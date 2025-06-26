import 'package:flutter/material.dart';

class AProposDeNousPage extends StatelessWidget {
  const AProposDeNousPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('À propos de nous'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            // Logo de l'application
            Image.asset(
              'assets/logo.jpeg',
              width: 90,
              height: 90,
            ),
            const SizedBox(height: 24),
            const Text(
              'Finesgram',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Votre application de gestion financière simple, rapide et sécurisée.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 12),
            const Text(
              'Développé par :',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text('L’équipe Finesgram'),
            const SizedBox(height: 12),
            const Text('Version 1.0.0'),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 12),
            const Text(
              'Contact : finesgramstudent@gmail.com',
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 24),
            const Text(
              'Merci d’utiliser Finesgram !',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
