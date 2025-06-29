import 'package:flutter/material.dart';
import 'package:finesgram/transaction_form_page.dart';

class RevenuPage extends StatelessWidget {
  const RevenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TransactionFormPage(
      title: 'Nouveau Revenu',
      typeLabel: 'Source de revenu',
      successMessage: 'Revenu enregistré✅',
      appBarColor: Colors.green[200]!,
      onSubmit: (double montant, String description, String? categorie,
          DateTime date) async {
        // Logique pour enregistrer le revenu
      },
    );
  }
}
