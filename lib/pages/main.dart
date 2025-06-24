import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/historique_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/entree_page.dart';
import 'pages/inscription_page.dart';
import 'pages/connexion_page.dart';
import 'pages/accueil_page.dart';
import 'pages/revenu_page.dart';
import 'pages/depense_page.dart';
import 'pages/epargne_page.dart';
import 'pages/objectif_page.dart';
import 'pages/parametres_page.dart';

// test
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion financière',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: GoogleFonts.poppinsTextTheme(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/entree',
      routes: {
        '/entree': (context) => const EntreePage(),
        '/inscription': (context) => const InscriptionPage(),
        '/connexion': (context) => const ConnexionPage(),
        '/accueil': (context) => const AccueilPage(),
        '/revenu': (context) => const RevenuPage(),
        '/depense': (context) => const DepensePage(),
        '/epargne': (context) => const EpargnePage(),
        '/objectifs': (context) => const ObjectifsPage(),
        '/historique': (context) => HistoriquePage(
              transactions: [],
            ),
        '/parametres': (context) => ParametresPage(
              userEmail: 'email_utilisateur',
              onLogout: () {
                Navigator.of(context).pushReplacementNamed('/connexion');
              },
              onThemeChange: (bool value) {},
              onFontSizeChange: (double value) {},
            ),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => const EntreePage(),
      ),
    );
  }
}
