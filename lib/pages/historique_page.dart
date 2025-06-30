import 'package:flutter/material.dart';
import 'package:finesgram/models/transaction.dart';

class HistoriquePage extends StatelessWidget {
  final List<Transaction> transactions;

  const HistoriquePage({Key? key, required this.transactions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF5F6FA), Color(0xFFE3E6F3)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.indigo[200],
                    child: const Icon(Icons.history, size: 32, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "Historique",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF283593),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Expanded(
                child: transactions.isEmpty
                    ? const Center(child: Text('Aucune transaction enregistrée.'))
                    : ListView.builder(
                        itemCount: transactions.length,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        itemBuilder: (context, index) {
                          final transaction = transactions[index];
                          return Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            margin: const EdgeInsets.only(bottom: 14),
                            child: ListTile(
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
                                size: 32,
                              ),
                              title: Text(transaction.titre, style: const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text(transaction.date.toString()),
                              trailing: Text('${transaction.montant} FC', style: const TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF283593),
        onPressed: () => _showFilterDialog(context),
        child: const Icon(Icons.filter_alt),
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
