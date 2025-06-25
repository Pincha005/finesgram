import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/parametres_page.dart';
import 'package:flutter_application_1/models/user_model.dart';

class AccueilPage extends StatefulWidget {
  final User user;

  const AccueilPage({Key? key, required this.user}) : super(key: key);

  @override
  State<AccueilPage> createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  // Déclaration des couleurs comme constantes
  static const _backgroundColor = Color.fromARGB(255, 183, 163, 104);
  static const _appBarColor = Color.fromARGB(255, 245, 248, 247);
  static const _buttonColor = Color.fromARGB(255, 203, 209, 157);
  static const _textColor = Color.fromARGB(255, 12, 12, 12);

  // Liste des boutons pour une meilleure maintenabilité
  final List<MenuButton> _menuButtons = [
    MenuButton(icon: Icons.attach_money, label: 'Revenu', route: '/revenu'),
    MenuButton(icon: Icons.shopping_cart, label: 'Dépense', route: '/depense'),
    MenuButton(icon: Icons.savings, label: 'Epargne', route: '/epargne'),
    MenuButton(icon: Icons.flag, label: 'Objectifs', route: '/objectifs'),
    MenuButton(icon: Icons.history, label: 'Historique', route: '/historique'),
    MenuButton(
      icon: Icons.settings,
      label: 'Paramètres',
      isSpecial: true, // Pour un comportement différent
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: _appBarColor,
      title: const Text(
        'Ton App, tes finances',
        style: TextStyle(color: _textColor),
      ),
      centerTitle: true,
      iconTheme: const IconThemeData(color: _textColor),
    );
  }

  Widget _buildBody() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (final button in _menuButtons) ...[
              _buildMenuButton(button),
              const SizedBox(height: 20),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(MenuButton button) {
    return SizedBox(
      width: 180, // Légèrement plus large pour mieux s'adapter au texte
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _buttonColor,
          foregroundColor: _textColor,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: BorderSide(color: _textColor.withOpacity(0.2)),
          ),
          elevation: 2,
        ),
        onPressed: () => button.isSpecial
            ? _navigateToSettings(context)
            : _navigateTo(context, button.route),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(button.icon, size: 28),
            const SizedBox(width: 12),
            Text(
              button.label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }

  void _navigateToSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ParametresPage(
          user: widget.user,
          onLogout: () {
            Navigator.pushReplacementNamed(context, '/connexion');
          },
          onThemeChange: (bool value) {},
          onFontSizeChange: (double value) {},
        ),
      ),
    );
  }
}

// Classe helper pour les boutons du menu
class MenuButton {
  final IconData icon;
  final String label;
  final String route;
  final bool isSpecial;

  MenuButton({
    required this.icon,
    required this.label,
    this.route = '',
    this.isSpecial = false,
  });
}
