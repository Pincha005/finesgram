import 'package:flutter/material.dart';
import 'package:finesgram/models/user_model.dart';
import 'package:finesgram/pages/edit_profil_page.dart';

class ProfilPage extends StatefulWidget {
  final User user;

  const ProfilPage({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  late User
      _currentUser; // Ajout d'une variable pour stocker l'utilisateur modifiable

  @override
  void initState() {
    super.initState();
    _currentUser =
        widget.user; // Initialisation avec l'utilisateur passé en paramètre
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Profil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _navigateToEditProfile(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 20),
            _buildProfileDetails(),
            const SizedBox(height: 30),
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: _currentUser.photoUrl != null
              ? NetworkImage(_currentUser.photoUrl!)
              : const AssetImage('assets/default_avatar.png') as ImageProvider,
        ),
        const SizedBox(height: 10),
        Text(
          _currentUser.nom,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          _currentUser.email,
          style: TextStyle(color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildProfileDetails() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildDetailItem(Icons.phone, 'Téléphone',
                _currentUser.telephone ?? 'Non renseigné'),
            const Divider(),
            _buildDetailItem(Icons.location_on, 'Adresse',
                _currentUser.adresse ?? 'Non renseignée'),
            const Divider(),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      subtitle: Text(value),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.logout),
        label: const Text('Déconnexion'),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.red,
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        onPressed: () => _confirmLogout(context),
      ),
    );
  }

  void _navigateToEditProfile(BuildContext context) async {
    final updatedUser = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilPage(user: _currentUser),
      ),
    );

    if (updatedUser != null && updatedUser is User) {
      setState(() {
        _currentUser = updatedUser; // Mise à jour de l'utilisateur
      });
    }
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
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/connexion');
            },
            child: const Text(
              'Déconnexion',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
