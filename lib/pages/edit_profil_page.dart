import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_model.dart';

class EditProfilPage extends StatefulWidget {
  final User user;

  const EditProfilPage({Key? key, required this.user}) : super(key: key);

  @override
  State<EditProfilPage> createState() => _EditProfilPageState();
}

class _EditProfilPageState extends State<EditProfilPage> {
  late TextEditingController nomController;
  late TextEditingController telephoneController;
  late TextEditingController adresseController;

  @override
  void initState() {
    super.initState();
    nomController = TextEditingController(text: widget.user.nom);
    telephoneController = TextEditingController(text: widget.user.telephone ?? '');
    adresseController = TextEditingController(text: widget.user.adresse ?? '');
  }

  @override
  void dispose() {
    nomController.dispose();
    telephoneController.dispose();
    adresseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Modifier mon profil')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nomController,
              decoration: const InputDecoration(labelText: 'Nom'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: telephoneController,
              decoration: const InputDecoration(labelText: 'Téléphone'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: adresseController,
              decoration: const InputDecoration(labelText: 'Adresse'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sauvegarderProfil,
              child: const Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }

  void _sauvegarderProfil() {
    final updatedUser = User(
      id: widget.user.id,
      nom: nomController.text,
      email: widget.user.email,
      photoUrl: widget.user.photoUrl,
      telephone: telephoneController.text,
      adresse: adresseController.text,
      dateInscription: widget.user.dateInscription,
    );

    Navigator.pop(context, updatedUser);
  }
}