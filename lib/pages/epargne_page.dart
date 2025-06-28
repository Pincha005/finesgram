import 'package:flutter/material.dart';
import 'package:finesgram/transaction_form_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finesgram/models/user_model.dart';

class EpargnePage extends StatelessWidget {
  final AppUser user;
  const EpargnePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TransactionFormPage(
      title: 'Nouvelle Épargne',
      typeLabel: "Type d'épargne",
      successMessage: 'Épargne enregistrée ✅',
      appBarColor: Colors.blue[200]!,
      onSubmit: (double montant, String description, String? categorie,
          DateTime date) async {
        await FirebaseFirestore.instance.collection('transactions').add({
          'userId': user.uid,
          'type': 'epargne',
          'montant': montant,
          'titre': description,
          'categorie': categorie,
          'date': date.toIso8601String(),
        });
      },
    );
  }
}
