import 'package:flutter/material.dart';

class AProposDeNousPage extends StatelessWidget {
  const AProposDeNousPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('À propos de nous'),
        backgroundColor: Color.fromARGB(255, 224, 153, 192),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 237, 236, 231),
              Color.fromARGB(255, 249, 248, 247)
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              const Text(
                'Finesgram',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(222, 176, 94, 74),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 18),
              const Text(
                "Finesgram est une application de gestion financière simple et intuitive, conçue pour aider les étudiants à suivre ses revenus, dépenses, épargnes et objectifs.\n\nNotre mission : rendre la gestion de vos finances accessible, agréable et efficace, pour les étudiants en premier et pour tous en dernier !\n\nDéveloppée avec passion par une équipe engagée.",
                style: TextStyle(fontSize: 17, color: Color(0xFF6D4C41)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              const Text(
                'Contact :finesgramstudent@gmail.com',
                style: TextStyle(fontSize: 15, color: Color(0xFFEF6C00)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
