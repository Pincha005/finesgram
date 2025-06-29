import 'package:flutter/material.dart';
import 'package:finesgram/models/user_model.dart';
import 'package:finesgram/transaction_form_page.dart';

class DepensePage extends StatelessWidget {
  final AppUser user;
  const DepensePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TransactionFormPage(
      title: 'Nouvelle Dépense',
      typeLabel: 'Source de dépense',
      successMessage: 'Dépense enregistrée ✅',
      appBarColor: Colors.red[200]!,
      onSubmit: (double montant, String description, String? categorie,
          DateTime date) async {
        // Suppression de toute logique Firestore dans depense_page.dart.
      },
    );
  }
}
