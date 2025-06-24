enum TransactionType {
  depense,
  revenu,
  epargne,
}

class Transaction {
  final String id;
  final String titre;
  final double montant;
  final DateTime date;
  final TransactionType type;
  final String? categorie; // Optionnel
  final String? description; // Optionnel

  Transaction({
    required this.id,
    required this.titre,
    required this.montant,
    required this.date,
    required this.type,
    this.categorie,
    this.description,
  });

  // Méthode pour convertir en Map (utile pour Firebase)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titre': titre,
      'montant': montant,
      'date': date.toIso8601String(),
      'type': type.toString().split('.').last,
      'categorie': categorie,
      'description': description,
    };
  }

  // Méthode pour créer un objet Transaction depuis un Map
  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      titre: map['titre'],
      montant: map['montant'],
      date: DateTime.parse(map['date']),
      type: TransactionType.values.firstWhere(
        (e) => e.toString() == 'TransactionType.${map['type']}',
      ),
      categorie: map['categorie'],
      description: map['description'],
    );
  }
}
