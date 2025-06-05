// les importations

import 'package:flutter/material.dart'; // fichier contenant les outils graphiques de flu : boutons, textes, champ de saisie
//import 'package:http/http.dart' as http;
//import 'dart:convert';

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
  void dispose() { // cette fonction permet de liberer ces 3 champs libre afin de libérer de l'espace dans la memoire
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
 
 // fonction qui verifie et affiche les données du formulaire sans enregistrer dans base de données
  void _register() async{
    if (_formKey.currentState!.validate()) { // cette condition verifie si tous les champs sont valides
      print('Nom : ${_usernameController.text}');
      print('Email: ${_emailController.text}');
      print('Mot de passe : ${_passwordController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: const Text('Inscription')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration:
                    const InputDecoration(labelText: 'Nom de l’utilisateur'),
                validator: (value) {
                  if (value == null || value.isEmpty ) {
                    return 'Veuillez entrer un nom d’utilsateur';
                  }
                  return null;
                },
                    
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) => value == null || !value.contains('@')
                    ? 'Entrez un Email valide'
                    : null,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Mot de passe'),
                obscureText: true,
                validator: (value) => value == null || value.length < 6
                    ? 'Minimum 6 caractères'
                    : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _register,
                // envoyerDonnees(); // APPEL DE LA FONCTION

                child: const Text('S inscrire'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/connexion');
                },
                child: const Text("Déjà un compte? Connectez vous!"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
