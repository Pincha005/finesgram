import 'package:flutter/material.dart';
import 'package:flutter_application_1/transaction_form_page.dart';

class EpargnePage extends StatelessWidget {
  const EpargnePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TransactionFormPage(
      title: 'Nouvelle Épargne',
      typeLabel: 'Type d\'épargne',
      successMessage: 'Épargne enregistrée ✅',
      appBarColor: Colors.blue[200]!,
      // Couleur spécifique
    );
  }
}
