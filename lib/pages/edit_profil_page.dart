import 'package:flutter/material.dart';
import 'package:finesgram/models/user_model.dart';

class EditProfilPage extends StatefulWidget {
  final AppUser user;

  const EditProfilPage({Key? key, required this.user}) : super(key: key);

  @override
  State<EditProfilPage> createState() => _EditProfilPageState();
}

class _EditProfilPageState extends State<EditProfilPage> {
  late final TextEditingController _nomController;
  late final TextEditingController _emailController;
  late final TextEditingController _telephoneController;
  late final TextEditingController _adresseController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _telephoneController =
        TextEditingController(text: widget.user.telephone ?? '');
    _adresseController = TextEditingController(text: widget.user.adresse ?? '');
  }

  @override
  void dispose() {
    _nomController.dispose();
    _emailController.dispose();
    _telephoneController.dispose();
    _adresseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifier le profil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveProfile,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildAvatarSection(),
              const SizedBox(height: 24),
              _buildFormField(
                controller: _nomController,
                label: 'Nom complet',
                icon: Icons.person,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Ce champ est obligatoire' : null,
              ),
              const SizedBox(height: 16),
              _buildFormField(
                controller: _emailController,
                label: 'Email',
                icon: Icons.email,
                enabled: false, // Email non modifiable
              ),
              const SizedBox(height: 16),
              _buildFormField(
                controller: _telephoneController,
                label: 'Téléphone',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              _buildFormField(
                controller: _adresseController,
                label: 'Adresse',
                icon: Icons.location_on,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  child: const Text('Enregistrer les modifications'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarSection() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: widget.user.photoUrl != null
                ? NetworkImage(widget.user.photoUrl!)
                : const AssetImage('assets/default_avatar.png')
                    as ImageProvider,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              child:
                  const Icon(Icons.camera_alt, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool enabled = true,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      enabled: enabled,
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  void _saveProfile() async {
    if (_formKey.currentState?.validate() ?? false) {
      final updatedUser = AppUser(
        uid: widget.user.uid,
        name: _nomController.text,
        email: _emailController.text,
        photoUrl: widget.user.photoUrl,
        telephone: _telephoneController.text.isEmpty
            ? null
            : _telephoneController.text,
        adresse:
            _adresseController.text.isEmpty ? null : _adresseController.text,
      );
      // Mise à jour locale uniquement (plus de Firestore)
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profil mis à jour !')),
        );
        Navigator.pop(context, updatedUser);
      }
    }
  }
}
