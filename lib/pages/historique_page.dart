import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/transaction.dart';

class HistoriquePage extends StatefulWidget {
  final List<Transaction> transactions;

  const HistoriquePage({super.key, required this.transactions});

  @override
  State<HistoriquePage> createState() => _HistoriquePageState();
}

class _HistoriquePageState extends State<HistoriquePage> {
  TransactionType? _filterType;
  bool _newestFirst = true;

  List<Transaction> get _filteredTransactions {
    var transactions = widget.transactions
        .where((t) => _filterType == null || t.type == _filterType)
        .toList();

    transactions.sort((a, b) =>
        _newestFirst ? b.date.compareTo(a.date) : a.date.compareTo(b.date));

    return transactions;
  }

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
      body: _filteredTransactions.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              itemCount: _filteredTransactions.length,
              itemBuilder: (context, index) =>
                  _TransactionCard(transaction: _filteredTransactions[index]),
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.history, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            _filterType == null
                ? 'Aucune transaction'
                : 'Aucune transaction de ce type',
            style: const TextStyle(fontSize: 18),
          ),
        ],
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
            RadioListTile<TransactionType?>(
              title: const Text('Tous'),
              value: null,
              groupValue: _filterType,
              onChanged: (value) => _applyFilter(value),
            ),
            ...TransactionType.values.map((type) => RadioListTile(
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

  void _applyFilter(TransactionType? type) {
    setState(() => _filterType = type);
    Navigator.pop(context);
  }

  void _applySort(bool newestFirst) {
    setState(() => _newestFirst = newestFirst);
    Navigator.pop(context);
  }
}

class _TransactionCard extends StatelessWidget {
  final Transaction transaction;

  const _TransactionCard({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final color =
        transaction.type == TransactionType.depense ? Colors.red : Colors.green;

    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: Icon(
          transaction.type == TransactionType.depense
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
