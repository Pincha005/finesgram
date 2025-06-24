import 'package:flutter/material.dart';

class ConnexionPage extends StatefulWidget {
  const ConnexionPage({Key? key}) : super(key: key);

  @override
  _ConnexionPageState createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<ConnexionPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 2));

      setState(() => _isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Connexion réussie!')),
      );
      Navigator.pushReplacementNamed(context, '/accueil');
    }
  }

  @override
  Widget build(BuildContext) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 183, 163, 104),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 48.0),
                const FlutterLogo(size: 100),
                const SizedBox(height: 24.0),
                Text(
                  'connexion',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium, // before it was headline4
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48.0),
                //champ email
                TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
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
                    }),
                const SizedBox(height: 16.0),

                // champ mot de passe
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    prefixIcon: const Icon(Icons.lock),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                    ),
                  ),
                  obscureText: _obscurePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre mot de passe';
                    }
                    if (value.length < 6) {
                      return '6 caractères minimum';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8.0),

                // lien mot de passe oublié
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Mot de passe oublié?'),
                  ),
                ),
                // Bouton de connexion

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: _isLoading ? null : _submit,
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Se connecter',
                          style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 16.0),

                // lien vers inscription

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Pas encore inscrit?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/inscription');
                      },
                      child: const Text('Créer un compte'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
