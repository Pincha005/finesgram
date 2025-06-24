import 'package:flutter/material.dart';

class DepensePage extends StatefulWidget {
  const DepensePage({Key? key}) : super(key: key);

  @override
  State<DepensePage> createState() => _DepensePageState();
}

class _DepensePageState extends State<DepensePage> {
  final _formKey = GlobalKey<FormState>();
  final _montantController = TextEditingController();
  final _sourceController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Dépense enregistré ✅')));

      _montantController.clear();
      _sourceController.clear();
      setState(() => _selectedDate = DateTime.now());
    }
  }

  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 241, 240, 147),
        title: const Text('Dépenses'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _montantController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Montant (FC)'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Entrer un montant' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _sourceController,
                decoration: const InputDecoration(labelText: 'Type de dépense'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Entrer une type' : null,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Date : ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                    onPressed: _pickDate,
                    child: const Text('Choisir une date'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Enregistrer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
