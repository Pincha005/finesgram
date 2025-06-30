import 'package:flutter/material.dart';
import 'package:finesgram/pages/historique_page.dart';
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
import 'package:finesgram/models/user_model.dart';
import 'pages/commentaire_page.dart';
import 'pages/a_propos_de_nous_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;
  double _fontSize = 14;

  void _toggleTheme(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  void _changeFontSize(double value) {
    setState(() {
      _fontSize = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion financière',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: GoogleFonts.poppinsTextTheme()
            .apply(fontSizeFactor: _fontSize / 14),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: const Color(0xFFF5F6FA),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFF181A20),
        cardColor: const Color(0xFF23243A),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF23243A)),
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme)
            .apply(fontSizeFactor: _fontSize / 14),
        colorScheme: ColorScheme.dark(
          primary: Colors.indigo,
          secondary: Colors.amber,
        ),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.all(Colors.amber),
          trackColor: MaterialStateProperty.all(Colors.indigo),
        ),
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      initialRoute: '/entree',
      routes: {
        '/entree': (context) => const EntreePage(),
        '/inscription': (context) => const InscriptionPage(),
        '/connexion': (context) => const ConnexionPage(),
        '/accueil': (context) => AccueilPage(
              user:
                  User(id: '1', nom: 'Pincha', email: 'pinchakalala@email.com'),
            ),
        '/revenu': (context) => const RevenuPage(),
        '/depense': (context) => const DepensePage(),
        '/epargne': (context) => const EpargnePage(),
        '/objectifs': (context) => const ObjectifsPage(),
        '/historique': (context) => HistoriquePage(
              transactions: [],
            ),
        '/parametres': (context) {
          final args = ModalRoute.of(context)!.settings.arguments;
          if (args is User) {
            return ParametresPage(
              user: args,
              onLogout: () {
                Navigator.of(context).pushReplacementNamed('/connexion');
              },
              onThemeChange: _toggleTheme,
              onFontSizeChange: _changeFontSize,
            );
          } else {
            return const EntreePage(); // fallback
          }
        },
        '/profil': (context) {
          final args = ModalRoute.of(context)!.settings.arguments;
          if (args is User) {
            return ProfilPage(
              user: args,
            );
          } else {
            return const EntreePage();
          }
        },
        '/commentaire': (context) {
          return const CommentairePage();
        },
        '/a_propos_de_nous': (context) => const AProposDeNousPage(),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => const EntreePage(),
      ),
    );
  }
}
