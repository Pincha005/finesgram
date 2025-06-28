import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('transactions')
            .where('userId', isEqualTo: widget.userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return _buildEmptyState();
          }
          List<model.Transaction> transactions = [];
          for (var doc in snapshot.data!.docs) {
            try {
              final t =
                  model.Transaction.fromMap(doc.data() as Map<String, dynamic>);
              if (_filterType == null || t.type == _filterType) {
                transactions.add(t);
              }
            } catch (_) {
              // Ignore transaction if malformed
              continue;
            }
          }
          transactions.sort((a, b) => _newestFirst
              ? b.date.compareTo(a.date)
              : a.date.compareTo(b.date));
          if (transactions.isEmpty) return _buildEmptyState();
          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) =>
                _TransactionCard(transaction: transactions[index]),
          );
        },
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
