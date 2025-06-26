import 'package:flutter/material.dart';
import 'package:flutter_application_1/transaction_form_page.dart';

class DepensePage extends StatelessWidget {
  const DepensePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TransactionFormPage(
      title: 'Nouvelle Dépense',
      typeLabel: 'Source de dépense',
      successMessage: 'Dépense enregistrée ✅',
      appBarColor: Colors.red[200]!,
    );
  }
}
