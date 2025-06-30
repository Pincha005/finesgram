import 'package:flutter/material.dart';
import 'package:finesgram/pages/parametres_page.dart';
import 'package:finesgram/models/user_model.dart';

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
  static const _textColor = Color.fromARGB(255, 12, 12, 12);

  // Liste des boutons pour une meilleure maintenabilité
  final List<MenuButton> _menuButtons = [
    MenuButton(icon: Icons.attach_money, label: 'Revenu', route: '/revenu', color: Color(0xFF388E3C)),
    MenuButton(icon: Icons.shopping_cart, label: 'Dépense', route: '/depense', color: Color(0xFFB71C1C)),
    MenuButton(icon: Icons.savings, label: 'Épargne', route: '/epargne', color: Color(0xFFFBC02D)),
    MenuButton(icon: Icons.flag, label: 'Objectifs', route: '/objectifs', color: Color(0xFFEF6C00)),
    MenuButton(icon: Icons.history, label: 'Historique', route: '/historique', color: Color(0xFF283593)),
    MenuButton(
      icon: Icons.settings,
      label: 'Paramètres',
      isSpecial: true,
      color: Color(0xFF757575),
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
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF5F6FA), Color(0xFFE3E6F3)],
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Header visuel amélioré
                Material(
                  elevation: 6,
                  shape: const CircleBorder(),
                  child: CircleAvatar(
                    radius: 44,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.indigo[200],
                      child: const Icon(Icons.account_circle, size: 48, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Bonjour, ${widget.user.nom}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF283593),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 2),
                Text(
                  widget.user.email,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.indigo[400],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 18),
                const Text(
                  'Gérez vos finances simplement',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF283593),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    for (final button in _menuButtons) _buildMenuButton(button),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(MenuButton button) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(22),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          splashColor: button.color.withOpacity(0.2),
          onTap: () => button.isSpecial
              ? _navigateToSettings(context)
              : _navigateTo(context, button.route),
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: button.color,
              boxShadow: [
                BoxShadow(
                  color: button.color.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(button.icon, size: 38, color: Colors.white),
                const SizedBox(height: 10),
                Text(
                  button.label,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, String route) {
    Navigator.pushNamed(context, route, arguments: widget.user);
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
  final Color color;

  MenuButton({
    required this.icon,
    required this.label,
    this.route = '',
    this.isSpecial = false,
    required this.color,
  });
}
