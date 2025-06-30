import 'package:flutter/material.dart';

class RevenuPage extends StatefulWidget {
  const RevenuPage({Key? key}) : super(key: key);

  @override
  State<RevenuPage> createState() => _RevenuPageState();
}

class _RevenuPageState extends State<RevenuPage> {
  final _formKey = GlobalKey<FormState>();
  final _montantController = TextEditingController();
  final _sourceController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Revenu enregistré ✅')));

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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF5F6FA), Color(0xFFE3F6E3)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.green[300],
                    child: const Icon(Icons.attach_money,
                        size: 40, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Ajouter un revenu',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF388E3C),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _montantController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Montant (FC)',
                            prefixIcon: const Icon(Icons.money,
                                color: Color(0xFF388E3C)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Entrer un montant'
                              : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _sourceController,
                          decoration: InputDecoration(
                            labelText: 'Source du revenu',
                            prefixIcon: const Icon(Icons.source,
                                color: Color(0xFF388E3C)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Entrer une source'
                              : null,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Date : ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                            TextButton(
                              onPressed: _pickDate,
                              child: const Text('Choisir une date'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF388E3C),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              textStyle: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            child: const Text('Enregistrer'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
