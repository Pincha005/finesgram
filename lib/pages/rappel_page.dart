import 'package:flutter/material.dart';

class RappelPage extends StatefulWidget {
  const RappelPage({super.key});

  @override
  State<RappelPage> createState() => _RappelPageState();
}

class _RappelPageState extends State<RappelPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime? _dateDebut;
  TimeOfDay? _heure;
  String _frequence = 'Une fois';

  final List<String> _frequences = [
    'Une fois',
    'Tous les jours',
    'Hebdomadaire',
    'Mensuel',
  ];

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: _dateDebut ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );
    if (date != null) setState(() => _dateDebut = date);
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _heure ?? TimeOfDay.now(),
    );
    if (time != null) setState(() => _heure = time);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer un rappel'),
        backgroundColor: const Color.fromARGB(255, 83, 109, 254),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomController,
                decoration: const InputDecoration(
                  labelText: 'Nom du rappel',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Veuillez entrer un nom.'
                    : null,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _frequence,
                items: _frequences
                    .map((f) => DropdownMenuItem(value: f, child: Text(f)))
                    .toList(),
                onChanged: (val) => setState(() => _frequence = val!),
                decoration: const InputDecoration(
                  labelText: 'Fréquence de rappel',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: _pickDate,
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Date de début',
                          border: OutlineInputBorder(),
                        ),
                        child: Text(
                          _dateDebut == null
                              ? 'Sélectionner une date'
                              : '${_dateDebut!.day}/${_dateDebut!.month}/${_dateDebut!.year}',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InkWell(
                      onTap: _pickTime,
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: "Heure",
                          border: OutlineInputBorder(),
                        ),
                        child: Text(
                          _heure == null
                              ? 'Sélectionner une heure'
                              : _heure!.format(context),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _noteController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Note',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Ici tu pourras ajouter la logique de sauvegarde ou de notification
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Rappel enregistré !')),
                    );
                  }
                },
                icon: const Icon(Icons.alarm),
                label: const Text('Enregistrer'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigoAccent,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
