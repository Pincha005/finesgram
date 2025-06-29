import 'package:flutter/material.dart';
import 'package:finesgram/models/transaction.dart' as model;

class HistoriquePage extends StatefulWidget {
  final String userId;
  const HistoriquePage({super.key, required this.userId});

  @override
  State<HistoriquePage> createState() => _HistoriquePageState();
}

class _HistoriquePageState extends State<HistoriquePage> {
  model.TransactionType? _filterType;
  bool _newestFirst = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historique'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: _showSortDialog,
          ),
        ],
      ),
      body: Center(
        child: Text('Historique des transactions de l\'utilisateur ${widget.userId}'),
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filtrer'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<model.TransactionType?>(
              title: const Text('Tous'),
              value: null,
              groupValue: _filterType,
              onChanged: (value) => _applyFilter(value),
            ),
            ...model.TransactionType.values.map((type) => RadioListTile(
                  title: Text(type.toString().split('.').last),
                  value: type,
                  groupValue: _filterType,
                  onChanged: (value) => _applyFilter(value),
                )),
          ],
        ),
      ),
    );
  }

  void _showSortDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Trier'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<bool>(
              title: const Text('Plus récent en premier'),
              value: true,
              groupValue: _newestFirst,
              onChanged: (value) => _applySort(value ?? true),
            ),
            RadioListTile<bool>(
              title: const Text('Plus ancien en premier'),
              value: false,
              groupValue: _newestFirst,
              onChanged: (value) => _applySort(value ?? true),
            ),
          ],
        ),
      ),
    );
  }

  void _applyFilter(model.TransactionType? type) {
    setState(() => _filterType = type);
    Navigator.pop(context);
  }

  void _applySort(bool newestFirst) {
    setState(() => _newestFirst = newestFirst);
    Navigator.pop(context);
  }
}

class _TransactionCard extends StatelessWidget {
  final model.Transaction transaction;
  const _TransactionCard({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final color = transaction.type == model.TransactionType.depense
        ? Colors.red
        : Colors.green;
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: Icon(
          transaction.type == model.TransactionType.depense
              ? Icons.arrow_upward
              : Icons.arrow_downward,
          color: color,
        ),
        title: Text(transaction.titre),
        subtitle: Text(transaction.date.toString()),
        trailing: Text(
          '${transaction.montant} €',
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
