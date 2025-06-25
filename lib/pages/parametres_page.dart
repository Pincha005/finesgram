import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_model.dart';

class ParametresPage extends StatefulWidget {
  final User user;
  final Function() onLogout;
  final Function(bool) onThemeChange;
  final Function(double) onFontSizeChange;

  const ParametresPage({
    Key? key,
    required this.user,
    required this.onLogout,
    required this.onThemeChange,
    required this.onFontSizeChange,
  }) : super(key: key);

  @override
  _ParametresPageState createState() => _ParametresPageState();
}

class _ParametresPageState extends State<ParametresPage> {
  double _currentFontSize = 14;
  bool _isDarkMode = false;
  bool _depenseReminder = true;
  bool _revenuReminder = true;
  bool _epargneConfirmation = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Profil
            _buildSectionHeader('Compte & Profil'),
            _buildListTile(
              icon: Icons.person,
              title: 'Profil',
              subtitle: widget.user.email,
              onTap: _goToProfile,
            ),
            const Divider(),

            // Section Rappels
            _buildSectionHeader('Rappels & Confirmations'),
            _buildSwitchTile(
              icon: Icons.shopping_cart,
              title: 'Rappel de dépenses',
              value: _depenseReminder,
              onChanged: (val) => setState(() => _depenseReminder = val),
            ),
            _buildSwitchTile(
              icon: Icons.attach_money,
              title: 'Rappel de revenus',
              value: _revenuReminder,
              onChanged: (val) => setState(() => _revenuReminder = val),
            ),
            _buildSwitchTile(
              icon: Icons.savings,
              title: 'Confirmation épargne',
              value: _epargneConfirmation,
              onChanged: (val) => setState(() => _epargneConfirmation = val),
            ),
            const Divider(),

            // Section Apparence
            _buildSectionHeader('Apparence'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text('Taille de police: ${_currentFontSize.toInt()}'),
            ),
            Slider(
              value: _currentFontSize,
              min: 12,
              max: 24,
              divisions: 6,
              label: _currentFontSize.round().toString(),
              onChanged: (value) {
                setState(() => _currentFontSize = value);
                widget.onFontSizeChange(value);
              },
            ),
            _buildSwitchTile(
              icon: _isDarkMode ? Icons.light_mode : Icons.dark_mode,
              title: 'Mode sombre',
              value: _isDarkMode,
              onChanged: (val) {
                setState(() => _isDarkMode = val);
                widget.onThemeChange(val);
              },
            ),
            const Divider(),

            // Section Déconnexion
            _buildSectionHeader('Sécurité'),
            _buildListTile(
              icon: Icons.logout,
              title: 'Déconnexion',
              color: Colors.red,
              onTap: _confirmLogout,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Color? color,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color)),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      secondary: Icon(icon),
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }

  void _goToProfile() {
    Navigator.pushNamed(
      context,
      '/profil',
      arguments: widget.user,
    );
  }

  void _confirmLogout() {
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
              widget.onLogout();
            },
            child:
                const Text('Déconnexion', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
