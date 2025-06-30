import 'package:flutter/material.dart';
import 'package:finesgram/models/user_model.dart';

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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF5F6FA),
              Color(0xFFE3E6F3),
              Color(0xFFFFF9C4),
              Color(0xFFE1F5FE)
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 38,
                        backgroundColor: Colors.orange[200],
                        child: const Icon(Icons.settings,
                            size: 38, color: Color(0xFF757575)),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.user.nom,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF283593)),
                      ),
                      Text(
                        widget.user.email,
                        style:
                            TextStyle(fontSize: 14, color: Colors.indigo[400]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildSectionHeader('Compte & Profil',
                          color: const Color(0xFF283593)),
                      _buildListTile(
                        icon: Icons.person,
                        title: 'Profil',
                        subtitle: widget.user.email,
                        onTap: _goToProfile,
                        color: const Color(0xFF283593),
                      ),
                      const Divider(),
                      _buildSectionHeader('Rappels & Confirmations',
                          color: Color(0xFFEF6C00)),
                      _buildSwitchTile(
                        icon: Icons.shopping_cart,
                        title: 'Rappel de dépenses',
                        value: _depenseReminder,
                        onChanged: (val) =>
                            setState(() => _depenseReminder = val),
                        activeColor: Colors.red,
                      ),
                      _buildSwitchTile(
                        icon: Icons.attach_money,
                        title: 'Rappel de revenus',
                        value: _revenuReminder,
                        onChanged: (val) =>
                            setState(() => _revenuReminder = val),
                        activeColor: Colors.green,
                      ),
                      _buildSwitchTile(
                        icon: Icons.savings,
                        title: 'Confirmation épargne',
                        value: _epargneConfirmation,
                        onChanged: (val) =>
                            setState(() => _epargneConfirmation = val),
                        activeColor: Colors.amber,
                      ),
                      const Divider(),
                      _buildSectionHeader('Apparence',
                          color: Color(0xFFFBC02D)),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Text(
                            'Taille de police: ${_currentFontSize.toInt()}'),
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
                        activeColor: Colors.amber,
                        inactiveColor: Colors.amber[100],
                      ),
                      _buildSwitchTile(
                        icon: _isDarkMode ? Icons.light_mode : Icons.dark_mode,
                        title: 'Mode sombre',
                        value: _isDarkMode,
                        onChanged: (val) {
                          setState(() => _isDarkMode = val);
                          widget.onThemeChange(val);
                        },
                        activeColor: Colors.indigo,
                      ),
                      const Divider(),
                      _buildSectionHeader('Plus', color: Color(0xFF388E3C)),
                      _buildListTile(
                        icon: Icons.comment,
                        title: 'Commentaire',
                        color: Colors.green,
                        onTap: () => Navigator.pushNamed(
                            context, '/commentaire',
                            arguments: widget.user),
                      ),
                      _buildListTile(
                        icon: Icons.info_outline,
                        title: 'À propos de nous',
                        color: const Color.fromARGB(255, 197, 130, 179),
                        onTap: () => Navigator.pushNamed(
                            context, '/a_propos_de_nous',
                            arguments: widget.user),
                      ),
                      const Divider(),
                      _buildSectionHeader('Sécurité', color: Colors.red),
                      _buildListTile(
                        icon: Icons.logout,
                        title: 'Déconnexion',
                        color: Colors.red,
                        onTap: _confirmLogout,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {Color color = Colors.black87}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: color,
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
    Color activeColor = Colors.blue,
  }) {
    return SwitchListTile(
      secondary: Icon(icon),
      title: Text(title),
      value: value,
      onChanged: onChanged,
      activeColor: activeColor,
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
