import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/models/transaction.dart';

class AccueilPage extends StatelessWidget {
  final User user;

  const AccueilPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bonjour, ${user.nom.split(' ').first}'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          _buildMenuButton(
            context,
            icon: Icons.attach_money,
            label: 'Revenu',
            color: Colors.green,
            onTap: () => Navigator.pushNamed(context, '/revenu'),
          ),
          _buildMenuButton(
            context,
            icon: Icons.shopping_cart,
            label: 'Dépense',
            color: Colors.red,
            onTap: () => Navigator.pushNamed(context, '/depense'),
          ),
          _buildMenuButton(
            context,
            icon: Icons.savings,
            label: 'Épargne',
            color: Colors.blue,
            onTap: () => Navigator.pushNamed(context, '/epargne'),
          ),
          _buildMenuButton(
            context,
            icon: Icons.flag,
            label: 'Objectifs',
            color: Colors.purple,
            onTap: () => Navigator.pushNamed(context, '/objectifs'),
          ),
          _buildMenuButton(
            context,
            icon: Icons.history,
            label: 'Historique',
            color: Colors.orange,
            onTap: () => Navigator.pushNamed(
              context,
              '/historique',
              arguments: user.transactions,
            ),
          ),
          _buildMenuButton(
            context,
            icon: Icons.settings,
            label: 'Paramètres',
            color: Colors.grey,
            onTap: () => Navigator.pushNamed(
              context,
              '/parametres',
              arguments: user,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showQuickAddMenu(context),
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.teal,
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(height: 12),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showQuickAddMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Ajouter une transaction',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            _buildAddOption(
              context,
              icon: Icons.attach_money,
              label: 'Revenu',
              color: Colors.green,
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/revenu');
              },
            ),
            _buildAddOption(
              context,
              icon: Icons.shopping_cart,
              label: 'Dépense',
              color: Colors.red,
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/depense');
              },
            ),
            _buildAddOption(
              context,
              icon: Icons.savings,
              label: 'Épargne',
              color: Colors.blue,
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/epargne');
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildAddOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(label),
      onTap: onTap,
    );
  }
}
