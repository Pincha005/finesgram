import 'package:flutter/material.dart';

class ObjectifsPage extends StatefulWidget {
  const ObjectifsPage({Key? key}) : super(key: key);

  @override
  _ObjectifsPageState createState() => _ObjectifsPageState();
}

class _ObjectifsPageState extends State<ObjectifsPage> {
  // Liste pour stocker les objectifs
  final List<Map<String, dynamic>> _objectifs = [];

  // Contrôleurs pour les champs de texte
  final _nomController = TextEditingController();
  final _montantController = TextEditingController();
  final _dureeController = TextEditingController();
  final _montantActuelController = TextEditingController();

  @override
  void dispose() {
    _nomController.dispose();
    _montantController.dispose();
    _dureeController.dispose();
    _montantActuelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF5F6FA), Color(0xFFE3E6F3)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.orange[200],
                    child: const Icon(Icons.flag, size: 32, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "Mes Objectifs d'Épargne",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFEF6C00),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Expanded(
                child: _objectifs.isEmpty
                    ? const Center(child: Text('Aucun objectif ajouté'))
                    : ListView(
                        padding: const EdgeInsets.all(16),
                        children: _objectifs.map((objectif) {
                          final montantJournalier = objectif['montant'] / objectif['duree'];
                          final progress = (objectif['montantActuel'] ?? 0) / objectif['montant'];
                          return Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                            margin: const EdgeInsets.only(bottom: 16),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    objectif['nom'],
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10),
                                  LinearProgressIndicator(
                                    value: progress,
                                    backgroundColor: Colors.grey[300],
                                    color: Colors.orange,
                                  ),
                                  const SizedBox(height: 10),
                                  Text('Objectif: ${objectif['montant']} FC'),
                                  Text('Durée : ${objectif['duree']} jours'),
                                  Text('À épargner/jour: $montantJournalier FC'),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () => _ajouterMontant(context, objectif),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFFEF6C00),
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: const Text('Ajouter un montant'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFEF6C00),
        onPressed: () => _ajouterObjectif(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _ajouterObjectif(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nouvel Objectif'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nomController,
              decoration: const InputDecoration(labelText: 'Nom'),
            ),
            TextField(
              controller: _montantController,
              decoration: const InputDecoration(labelText: 'Montant (FC)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _dureeController,
              decoration: const InputDecoration(labelText: 'Durée (jours)'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              if (_montantController.text.isNotEmpty &&
                  _dureeController.text.isNotEmpty) {
                setState(() {
                  _objectifs.add({
                    'nom': _nomController.text,
                    'montant': double.parse(_montantController.text),
                    'duree': int.parse(_dureeController.text),
                    'montantActuel': 0.0,
                  });
                  _nomController.clear();
                  _montantController.clear();
                  _dureeController.clear();
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Valider'),
          ),
        ],
      ),
    );
  }

  void _ajouterMontant(BuildContext context, Map<String, dynamic> objectif) {
    _montantActuelController.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajouter un montant'),
        content: TextField(
          controller: _montantActuelController,
          decoration: const InputDecoration(labelText: 'Montant épargné (FC)'),
          keyboardType: TextInputType.number,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              if (_montantActuelController.text.isNotEmpty) {
                setState(() {
                  final index = _objectifs.indexOf(objectif);
                  _objectifs[index]['montantActuel'] =
                      (_objectifs[index]['montantActuel'] ?? 0) +
                          double.parse(_montantActuelController.text);
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Ajouter'),
          ),
        ],
      ),
    );
  }
}
