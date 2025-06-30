enum TransactionType {
  revenu,
  depense,
  epargne,
}

class Transaction {
  final String id;
  final String titre;
  final double montant;
  final DateTime date;
  final TransactionType type;
  final String? categorie;
  final String? description;

  Transaction({
    required this.id,
    required this.titre,
    required this.montant,
    required this.date,
    required this.type,
    this.categorie,
    this.description,
  });

  // Méthode pour créer une copie avec des valeurs modifiées
  Transaction copyWith({
    String? id,
    String? titre,
    double? montant,
    DateTime? date,
    TransactionType? type,
    String? categorie,
    String? description,
  }) {
    return Transaction(
      id: id ?? this.id,
      titre: titre ?? this.titre,
      montant: montant ?? this.montant,
      date: date ?? this.date,
      type: type ?? this.type,
      categorie: categorie ?? this.categorie,
      description: description ?? this.description,
    );
  }

  // Conversion vers/à partir de Map pour Firebase
  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      titre: map['titre'],
      montant: map['montant'].toDouble(),
      date: DateTime.parse(map['date']),
      type: TransactionType.values[map['type']],
      categorie: map['categorie'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titre': titre,
      'montant': montant,
      'date': date.toIso8601String(),
      'type': type.index,
      'categorie': categorie,
      'description': description,
    };
  }
}

class User {
  final String id;
  final String nom;
  final String email;
  final String? photoUrl;
  final String? telephone;
  final String? adresse;
  final DateTime? dateInscription;
  final List<String>? objectifs;
  final List<Transaction> transactions;

  User({
    required this.id,
    required this.nom,
    required this.email,
    this.photoUrl,
    this.telephone,
    this.adresse,
    this.dateInscription,
    this.objectifs,
    this.transactions = const [],
  });

  // Méthode pour créer une copie avec des valeurs modifiées
  User copyWith({
    String? id,
    String? nom,
    String? email,
    String? photoUrl,
    String? telephone,
    String? adresse,
    DateTime? dateInscription,
    List<String>? objectifs,
    List<Transaction>? transactions,
  }) {
    return User(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      telephone: telephone ?? this.telephone,
      adresse: adresse ?? this.adresse,
      dateInscription: dateInscription ?? this.dateInscription,
      objectifs: objectifs ?? this.objectifs,
      transactions: transactions ?? this.transactions,
    );
  }

  // Conversion vers/à partir de Map pour Firebase
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      nom: map['nom'],
      email: map['email'],
      photoUrl: map['photoUrl'],
      telephone: map['telephone'],
      adresse: map['adresse'],
      dateInscription: map['dateInscription'] != null 
          ? DateTime.parse(map['dateInscription']) 
          : null,
      objectifs: map['objectifs'] != null 
          ? List<String>.from(map['objectifs']) 
          : null,
      transactions: map['transactions'] != null
          ? (map['transactions'] as List)
              .map((t) => Transaction.fromMap(t))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'email': email,
      'photoUrl': photoUrl,
      'telephone': telephone,
      'adresse': adresse,
      'dateInscription': dateInscription?.toIso8601String(),
      'objectifs': objectifs,
      'transactions': transactions.map((t) => t.toMap()).toList(),
    };
  }

  // Méthode utilitaire pour calculer le solde
  double get solde {
    final revenus = transactions
        .where((t) => t.type == TransactionType.revenu)
        .fold(0.0, (sum, t) => sum + t.montant);
    final depenses = transactions
        .where((t) => t.type == TransactionType.depense)
        .fold(0.0, (sum, t) => sum + t.montant);
    return revenus - depenses;
  }
}