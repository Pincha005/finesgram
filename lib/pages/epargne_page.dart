import 'package:flutter/material.dart';
import 'package:finesgram/transaction_form_page.dart';

class EpargnePage extends StatelessWidget {
  const EpargnePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TransactionFormPage(
      title: 'Nouvelle Épargne',
      typeLabel: "Type d'épargne",
      successMessage: 'Épargne enregistrée ✅',
      appBarColor: Colors.blue[200]!,
      onSubmit: (double montant, String description, String? categorie,
          DateTime date) async {
        // Suppression de toute logique Firestore dans epargne_page.dart.
      },
    );
  }
}
