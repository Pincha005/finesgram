enum TransactionType { revenu, depense, epargne }

class Transaction {
  final String titre;
  final double montant;
  final DateTime date;
  final TransactionType type;

  Transaction({
    required this.titre,
    required this.montant,
    required this.date,
    required this.type,
  });
}

class User {
  String id;
  String nom;
  String email;
  String? photoUrl;
  String? telephone;
  String? adresse;
  String? dateInscription;
  List<Transaction>? transactions;

  User({
    required this.id,
    required this.nom,
    required this.email,
    this.photoUrl,
    this.telephone,
    this.adresse,
    this.dateInscription,
    this.transactions,
  });
}
