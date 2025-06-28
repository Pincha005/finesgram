import 'package:flutter/material.dart';
import 'package:finesgram/transaction_form_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finesgram/models/user_model.dart';

class RevenuPage extends StatelessWidget {
  final AppUser user;
  const RevenuPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TransactionFormPage(
      title: 'Nouveau Revenu',
      typeLabel: 'Source de revenu',
      successMessage: 'Revenu enregistré✅',
      appBarColor: Colors.green[200]!,
      onSubmit: (double montant, String description, String? categorie,
          DateTime date) async {
        await FirebaseFirestore.instance.collection('transactions').add({
          'userId': user.uid,
          'type': 'revenu',
          'montant': montant,
          'titre': description,
          'categorie': categorie,
          'date': date.toIso8601String(),
        });
      },
    );
  }
}
