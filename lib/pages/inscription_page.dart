import 'package:flutter/material.dart'; // fichier contenant les outils graphiques de flu : boutons, textes, champ de saisie

// CREATION DE LA PAGE

class InscriptionPage extends StatefulWidget {
  // classe où tous les outils essentiels pour le bon fonctionnement de cette âge
  // parente page Dynamique ou qu'on peut mise à journée
  const InscriptionPage({Key? key}) : super(key: key);

  @override //redefinit ma classe 'inscriptionpage' par la classe parente
  _InscriptionPageState createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  final _formKey = GlobalKey<
      FormState>(); // c'est une clé qui verifie que le formulait est bien rempli
  // LES CONTROLEURS : permet de stocker ce que le user ecrit dans ces champs precis
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // cette fonction permet de liberer ces 3 champs libre afin de libérer de l'espace dans la memoire
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // fonction qui verifie et affiche les données du formulaire sans enregistrer dans base de données
  void _register() async {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(context, '/accueil');
      // cette condition verifie si tous les champs sont valides
      print('Nom : ${_usernameController.text}');
      print('Email: ${_emailController.text}');
      print('Mot de passe : ${_passwordController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 48,
                  backgroundColor: Colors.indigo[200],
                  child: const Icon(Icons.person_add, size: 48, color: Colors.white),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Créer un compte',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF283593),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Bienvenue sur Finesgram!",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.indigo[400],
                  ),
                ),
                const SizedBox(height: 32),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Nom de l’utilisateur',
                          prefixIcon: const Icon(Icons.person_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer un nom d’utilsateur';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: const Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email requis';
                          }
                          final parts = value.split('@');
                          if (parts.length != 2 || parts[1].split('.').length < 2) {
                            return 'Format: utilisateur@domaine.com';
                          }
                          final domainParts = parts[1].split('.');
                          if (domainParts.last.isEmpty ||
                              RegExp(r'[^a-zA-Z]').hasMatch(domainParts.last)) {
                            return 'Extension (.com/.fr) invalide';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Mot de passe',
                          prefixIcon: const Icon(Icons.lock_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        obscureText: true,
                        validator: (value) => value == null || value.length < 6
                            ? 'Minimum 6 caractères'
                            : null,
                      ),
                      const SizedBox(height: 28),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _register,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF283593),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          child: const Text('S’inscrire'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/connexion');
                        },
                        child: const Text(
                          "Déjà un compte ? Connectez-vous !",
                          style: TextStyle(fontSize: 15, color: Color(0xFF283593)),
                        ),
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
}
