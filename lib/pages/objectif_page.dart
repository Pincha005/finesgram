import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final _montantActuelController = TextEditingController();

  Color _getProgressColor(double progress) {
    if (progress < 0.3) return Colors.red;
    if (progress < 0.7) return Colors.orange;
    return Colors.green;
  }

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
    final user = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 179, 156, 89),
        title: const Text('Mes Objectifs d\'Épargne'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('objectifs')
            .where('userId', isEqualTo: user.id)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final objectifs = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return Objectif(
              id: doc.id,
              nom: data['nom'],
              montant: (data['montant'] as num).toDouble(),
              duree: data['duree'],
              montantActuel: (data['montantActuel'] as num).toDouble(),
            );
          }).toList();
          if (objectifs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.savings, size: 60, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  const Text(
                    'Aucun objectif défini',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Appuyez sur le bouton + pour créer un objectif',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: objectifs.length,
            itemBuilder: (context, index) =>
                _buildGoalCard(objectifs[index], user),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed: () => _showAddGoalDialog(context, user),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildGoalCard(Objectif objectif, User user) {
    final progress = objectif.montantActuel / objectif.montant;
    final dailyAmount = objectif.montant / objectif.duree;
    final remainingDays =
        ((objectif.montant - objectif.montantActuel) / dailyAmount).ceil();

    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    objectif.nom,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteGoal(objectif),
                ),
              ],
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              color: _getProgressColor(progress),
              minHeight: 10,
            ),
            const SizedBox(height: 10),
            Text(
              '${objectif.montantActuel}/${objectif.montant}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: [
                Chip(
                  label: Text('${objectif.duree} jours'),
                ),
                Chip(
                  label: Text('${dailyAmount.toStringAsFixed(0)} par jour'),
                ),
                Chip(
                  label: Text('$remainingDays jours restants'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _showAddAmountDialog(objectif),
                child: const Text('Ajouter un montant'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddGoalDialog(BuildContext context, User user) {
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
                await FirebaseFirestore.instance.collection('objectifs').add({
                  'userId': user.id,
                  'nom': _nomController.text,
                  'montant': double.parse(_montantController.text),
                  'duree': int.parse(_dureeController.text),
                  'montantActuel': 0.0,
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Créer'),
          ),
        ],
      ),
    );
  }

  void _showAddAmountDialog(Objectif objectif) {
    _montantActuelController.clear();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajouter un montant'),
        content: TextFormField(
          controller: _montantActuelController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Montant',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_montantActuelController.text.isNotEmpty) {
                final ajout = double.parse(_montantActuelController.text);
                await FirebaseFirestore.instance
                    .collection('objectifs')
                    .doc(objectif.id)
                    .update({
                  'montantActuel': objectif.montantActuel + ajout,
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

  void _deleteGoal(Objectif objectif) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer l\'objectif'),
        content: Text('Supprimer "${objectif.nom}" ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Non'),
          ),
          ElevatedButton(
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection('objectifs')
                  .doc(objectif.id)
                  .delete();
              Navigator.pop(context);
            },
            child: const Text('Oui'),
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
