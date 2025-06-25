import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/transaction.dart';

class HistoriquePage extends StatelessWidget {
  final List<Transaction> transactions;
  final Function(Transaction) addTransaction;

  const HistoriquePage({
    Key? key,
    required this.transactions,
    required this.addTransaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historique'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt),
            onPressed: () => _showFilterDialog(context),
          ),
        ],
      ),
      body: transactions.isEmpty
          ? const Center(child: Text('Aucune transaction enregistrée.'))
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return ListTile(
                  leading: Icon(
                    transaction.type == TransactionType.depense
                        ? Icons.shopping_cart
                        : transaction.type == TransactionType.revenu
                            ? Icons.attach_money
                            : Icons.savings,
                    color: transaction.type == TransactionType.depense
                        ? Colors.red
                        : transaction.type == TransactionType.revenu
                            ? Colors.green
                            : Colors.blue,
                  ),
                  title: Text(transaction.titre),
                  subtitle: Text(transaction.date.toString()),
                  trailing: Text('${transaction.montant} FC'),
                );
              },
            ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Filtrer'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: TransactionType.values.map((type) {
            return ListTile(
              title: Text(type.toString().split('.').last),
              onTap: () {
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

// Quand l'utilisateur valide :
