import 'package:flutter/material.dart';
import 'package:finesgram/models/user_model.dart';

class ProfilPage extends StatelessWidget {
  final AppUser user;

  const ProfilPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mon Profil')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    // Affichage initial basé sur le nom
                    CircleAvatar(
                      radius: 50,
                      child: Text(user.name[0],
                          style: const TextStyle(fontSize: 40)),
                    ),
                    // ...bouton de modification photo...
                  ],
                ),
                const SizedBox(height: 16),
                Text(user.name, style: const TextStyle(fontSize: 22)),
                Text(user.email, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: const Text('Téléphone'),
                  subtitle: Text(user.telephone ?? 'Non renseigné'),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.location_on),
                  title: const Text('Adresse'),
                  subtitle: Text(user.adresse ?? 'Non renseignée'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(
              context,
              '/edit-profil',
              arguments: user,
            ),
            child: const Text('Modifier le profil'),
          ),
          TextButton(
            onPressed: () => _confirmLogout(context),
            child:
                const Text('Déconnexion', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Déconnexion'),
        content: const Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, '/connexion'),
            child:
                const Text('Déconnecter', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
