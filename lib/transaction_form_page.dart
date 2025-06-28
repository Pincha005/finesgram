import 'package:flutter/material.dart';

class TransactionFormPage extends StatefulWidget {
  final String title;
  final String typeLabel;
  final String successMessage;
  final Color appBarColor;
  final Future<void> Function(
          double montant, String description, String? categorie, DateTime date)?
      onSubmit;

  const TransactionFormPage({
    Key? key,
    required this.title,
    required this.typeLabel,
    required this.successMessage,
    this.appBarColor = const Color.fromARGB(255, 241, 240, 147),
    this.onSubmit,
  }) : super(key: key);

  @override
  _TransactionFormPageState createState() => _TransactionFormPageState();
}

class _TransactionFormPageState extends State<TransactionFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _montantController = TextEditingController();
  final _typeController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String? _selectedCategory;

  List<String> _getCategories() {
    return [
      'Épargne',
      'Investissement',
      'Argent de poche',
      'Salaire',
      'Voyage',
      'shopping',
      'Dette',
      'Autre'
    ];
  }

  IconData _getTypeIcon() {
    if (widget.title.contains('Revenu')) return Icons.attach_money;
    if (widget.title.contains('Dépense')) return Icons.shopping_cart;
    return Icons.savings;
  }

  @override
  void dispose() {
    _montantController.dispose();
    _typeController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final montant = double.tryParse(_montantController.text) ?? 0;
      final description = _typeController.text;
      final categorie = _selectedCategory;
      final date = _selectedDate;
      if (widget.onSubmit != null) {
        await widget.onSubmit!(montant, description, categorie, date);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(widget.successMessage)),
      );
      _montantController.clear();
      _typeController.clear();
      setState(() => _selectedDate = DateTime.now());
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && mounted) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.appBarColor,
        title: Text(widget.title),
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
                decoration: const InputDecoration(
                  labelText: 'Montant (FC)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Entrer un montant' : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _typeController,
                decoration: InputDecoration(
                  labelText: widget.typeLabel,
                  border: const OutlineInputBorder(),
                  prefixIcon: Icon(_getTypeIcon()),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Ce champ est requis' : null,
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                items: _getCategories().map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                    // Ne pas modifier _typeController.text ici
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Catégorie',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Date : ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(width: 15),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColor,
                    ),
                    onPressed: _pickDate,
                    child: const Text('Choisir une date'),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: _submitForm,
                  child: const Text('Enregistrer'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
