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

  User copyWith({
    String? id,
    String? nom,
    String? email,
    String? photoUrl,
    String? telephone,
    String? adresse,
    String? dateInscription,
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
      transactions: transactions ?? this.transactions,
    );
  }
}

class AppUser {
  final String uid;
  final String name;
  final String email;
  final String? photoUrl;
  final String? telephone;
  final String? adresse;

  AppUser({
    required this.uid,
    required this.name,
    required this.email,
    this.photoUrl,
    this.telephone,
    this.adresse,
  });

  AppUser copyWith({
    String? uid,
    String? name,
    String? email,
    String? photoUrl,
    String? telephone,
    String? adresse,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      telephone: telephone ?? this.telephone,
      adresse: adresse ?? this.adresse,
    );
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      photoUrl: map['photoUrl'],
      telephone: map['telephone'],
      adresse: map['adresse'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'telephone': telephone,
      'adresse': adresse,
    };
  }
}
