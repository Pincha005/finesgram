import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:finesgram/models/user_model.dart';
import 'package:finesgram/pages/entree_page.dart';
import 'package:finesgram/pages/inscription_page.dart';
import 'package:finesgram/pages/connexion_page.dart';
import 'package:finesgram/pages/accueil_page.dart';
import 'package:finesgram/pages/revenu_page.dart';
import 'package:finesgram/pages/depense_page.dart';
import 'package:finesgram/pages/epargne_page.dart';
import 'package:finesgram/pages/objectif_page.dart';
import 'package:finesgram/pages/parametres_page.dart';
import 'package:finesgram/pages/profil_page.dart';
import 'package:finesgram/pages/edit_profil_page.dart';
import 'package:finesgram/pages/a_propos_de_nous_page.dart';
import 'package:finesgram/pages/commentaire_page.dart';
import 'package:finesgram/pages/historique_page.dart';
import 'package:finesgram/pages/rappel_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _darkMode = false;

  void _toggleTheme(bool value) {
    setState(() => _darkMode = value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion financière',
      theme: ThemeData(
        brightness: _darkMode ? Brightness.dark : Brightness.light,
        primarySwatch: Colors.teal,
        textTheme: GoogleFonts.poppinsTextTheme(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/entree',
      routes: {
        '/entree': (_) => const EntreePage(),
        '/inscription': (_) => const InscriptionPage(),
        '/connexion': (_) => const ConnexionPage(),
        '/accueil': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          if (args is AppUser) {
            return AccueilPage(user: args);
          }
          return _buildErrorPage(context, 'Accueil', args, 'AppUser');
        },
        '/revenu': (context) {
          return const RevenuPage();
        },
        '/depense': (context) =>
            _buildPageWithUser(context, (user) => DepensePage(user: user)),
        '/epargne': (context) => const EpargnePage(),
        '/objectif': (context) => const ObjectifsPage(),
        '/historique': (context) {
          final userId = ModalRoute.of(context)?.settings.arguments as String?;
          return userId != null
              ? HistoriquePage(userId: userId)
              : const ConnexionPage();
        },
        '/profil': (context) =>
            _buildPageWithUser(context, (user) => ProfilPage(user: user)),
        '/parametres': (context) {
          final user = ModalRoute.of(context)?.settings.arguments as AppUser?;
          return user != null
              ? ParametresPage(
                  user: user,
                  darkMode: _darkMode,
                  onThemeChanged: _toggleTheme,
                )
              : const ConnexionPage();
        },
        '/edit-profil': (context) =>
            _buildPageWithUser(context, (user) => EditProfilPage(user: user)),
        '/a_propos_de_nous': (_) => const AProposDeNousPage(),
        '/commentaire': (_) => const CommentairePage(),
        '/rappel': (_) => const RappelPage(),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => const EntreePage(),
      ),
    );
  }

  // Méthode helper pour construire les pages nécessitant un utilisateur
  Widget _buildPageWithUser(
    BuildContext context,
    Widget Function(AppUser) builder,
  ) {
    final user = ModalRoute.of(context)?.settings.arguments as AppUser?;
    return user != null ? builder(user) : const ConnexionPage();
  }

  // Méthode helper pour les pages d'erreur
  Widget _buildErrorPage(
    BuildContext context,
    String pageName,
    dynamic args,
    String expectedType,
  ) {
    return Scaffold(
      appBar: AppBar(title: Text('Erreur - $pageName')),
      body: Center(
        child: Text(
          'Erreur : argument de type incorrect pour la page $pageName.\n'
          'Reçu : ${args?.runtimeType}\n'
          'Attendu : $expectedType',
          style: const TextStyle(color: Colors.red, fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
