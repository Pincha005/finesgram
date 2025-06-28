import 'package:flutter/material.dart';
import 'package:finesgram/models/user_model.dart';

class ParametresPage extends StatelessWidget {
  final AppUser user;
  final bool darkMode;
  final ValueChanged<bool> onThemeChanged;

  const ParametresPage({
    super.key,
    required this.user,
    required this.darkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paramètres')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _UserCard(user: user),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.person),
            label: const Text('Mon profil'),
            onPressed: () => Navigator.pushNamed(
              context,
              '/profil',
              arguments: user,
            ),
          ),
          const SizedBox(height: 16),
          _AppearanceCard(
            darkMode: darkMode,
            onThemeChanged: onThemeChanged,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.info_outline),
            label: const Text('À propos de nous'),
            onPressed: () => Navigator.pushNamed(context, '/a_propos'),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.comment),
            label: const Text('Commentaires'),
            onPressed: () => Navigator.pushNamed(context, '/commentaire'),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.alarm),
            label: const Text('Rappels'),
            onPressed: () => Navigator.pushNamed(context, '/rappel'),
          ),
          const SizedBox(height: 16),
          _LogoutCard(
              onLogout: () =>
                  Navigator.pushReplacementNamed(context, '/connexion')),
        ],
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  final AppUser user;

  const _UserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text(user.name[0])),
        title: Text(user.name),
        subtitle: Text(user.email),
      ),
    );
  }
}

class _AppearanceCard extends StatelessWidget {
  final bool darkMode;
  final ValueChanged<bool> onThemeChanged;

  const _AppearanceCard({
    super.key,
    required this.darkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Apparence',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SwitchListTile(
              title: const Text('Mode sombre'),
              value: darkMode,
              onChanged: onThemeChanged,
            ),
          ],
        ),
      ),
    );
  }
}

class _LogoutCard extends StatelessWidget {
  final VoidCallback onLogout;

  const _LogoutCard({required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.logout, color: Colors.red),
        title: const Text('Déconnexion', style: TextStyle(color: Colors.red)),
        onTap: () => _confirmLogout(context),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Déconnexion'),
        content: const Text('Voulez-vous vraiment vous déconnecter ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onLogout();
            },
            child:
                const Text('Déconnecter', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
