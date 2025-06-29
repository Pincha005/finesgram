import 'package:flutter/material.dart';
import 'package:finesgram/models/user_model.dart';

class ObjectifsPage extends StatefulWidget {
  const ObjectifsPage({Key? key}) : super(key: key);

  @override
  _ObjectifsPageState createState() => _ObjectifsPageState();
}

class _ObjectifsPageState extends State<ObjectifsPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _montantController = TextEditingController();
  final _dureeController = TextEditingController();

  @override
  void dispose() {
    _nomController.dispose();
    _montantController.dispose();
    _dureeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 179, 156, 89),
        title: const Text('Mes Objectifs d\'Épargne'),
      ),
      body: Center(
        child: Text('Aucune donnée à afficher'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed: () => _showAddGoalDialog(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showAddGoalDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nouvel Objectif'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nomController,
                decoration: const InputDecoration(
                  labelText: 'Nom de l\'objectif',
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Champ obligatoire' : null,
              ),
              TextFormField(
                controller: _montantController,
                decoration: const InputDecoration(
                  labelText: 'Montant cible',
                ),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Champ obligatoire' : null,
              ),
              TextFormField(
                controller: _dureeController,
                decoration: const InputDecoration(
                  labelText: 'Durée (jours)',
                ),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Champ obligatoire' : null,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState?.validate() ?? false) {
                // Logique locale pour ajouter un objectif (à compléter si besoin)
                Navigator.pop(context);
              }
            },
            child: const Text('Créer'),
          ),
        ],
      ),
    );
  }
}

class Objectif {
  final String id;
  final String nom;
  final double montant;
  final int duree;
  final double montantActuel;

  Objectif({
    this.id = '',
    required this.nom,
    required this.montant,
    required this.duree,
    required this.montantActuel,
  });

  Objectif copyWith({
    String? id,
    String? nom,
    double? montant,
    int? duree,
    double? montantActuel,
  }) {
    return Objectif(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      montant: montant ?? this.montant,
      duree: duree ?? this.duree,
      montantActuel: montantActuel ?? this.montantActuel,
    );
  }
}
