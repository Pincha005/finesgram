import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/transaction.dart' as trans;
import 'package:flutter_application_1/models/user_model.dart';
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
import 'pages/profil_page.dart';
import 'pages/edit_profil_page.dart';

void main() => runApp(const MyApp());

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
        '/entree': (_) => const EntreePage(),
        '/inscription': (_) => const InscriptionPage(),
        '/connexion': (_) => const ConnexionPage(),
        '/accueil': (context) {
          final user = ModalRoute.of(context)?.settings.arguments as User;
          return AccueilPage(user: user);
        },
        '/revenu': (_) => const RevenuPage(),
        '/depense': (_) => const DepensePage(),
        '/epargne': (_) => const EpargnePage(),
        '/objectifs': (_) => const ObjectifsPage(),
        '/historique': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;

          // Gestion unifiée des transactions
          List<trans.Transaction> transactions = [];

          if (args is User) {
            transactions =
                args.transactions?.whereType<trans.Transaction>().toList() ??
                    [];
          } else if (args is List) {
            transactions = args.whereType<trans.Transaction>().toList();
          }

          return HistoriquePage(transactions: transactions);
        },
        '/profil': (context) {
          final user = ModalRoute.of(context)?.settings.arguments as User?;
          return user != null ? ProfilPage(user: user) : const ConnexionPage();
        },
        '/parametres': (context) {
          final user = ModalRoute.of(context)?.settings.arguments as User?;
          return user != null
              ? ParametresPage(user: user)
              : const ConnexionPage();
        },
        '/edit-profil': (context) {
          final user = ModalRoute.of(context)?.settings.arguments as User?;
          return user != null
              ? EditProfilPage(user: user)
              : const ConnexionPage();
        },
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => const EntreePage(),
      ),
    );
  }
}
