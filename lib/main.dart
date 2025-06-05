import 'package:flutter/material.dart';
import 'pages/accueil_page.dart';
import 'pages/inscription_page.dart';
import 'pages/connexion_page.dart';

void main() {
  //cette foction dit ce que l'appli est censé faire : le comportement de l'app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  // construire l'application 
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Mon application financière',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const AccueilPage(),
        // definition des routes
        routes: {
          '/accueil': (context) => const AccueilPage(),
          '/inscription': (context) => const InscriptionPage(),
          '/connexion': (context) => const ConnexionPage(),
         // '/connexion': (context)  => const InscriptionPage(),
          // on met 'const' devant les pages statiques afin que Flutter les construisent une seule fois
          // et epargne de donner du travaille au CPU et à la mémoire .
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
              builder: (context) =>
                  const AccueilPage()); // pour gerer les routes non definies
        });
  }
}
