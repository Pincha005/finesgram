import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CommentairePage extends StatefulWidget {
  const CommentairePage({Key? key}) : super(key: key);

  @override
  State<CommentairePage> createState() => _CommentairePageState();
}

class _CommentairePageState extends State<CommentairePage> {
  final TextEditingController _controller = TextEditingController();
  final String _appEmail = 'contact@finesgram.com'; // À personnaliser

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _envoyerCommentaire() async {
    final String commentaire = _controller.text.trim();
    if (commentaire.isEmpty) return;
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: _appEmail,
      query:
          'subject=Commentaire utilisateur&body=${Uri.encodeComponent(commentaire)}',
    );
    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Impossible d’ouvrir le client mail.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Envoyer un commentaire'),
        backgroundColor: const Color.fromARGB(255, 95, 56, 142),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF5F6FA), Color(0xFFE3F6E3)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              const Text(
                'Votre avis nous intéresse !',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 83, 56, 142)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 18),
              TextField(
                controller: _controller,
                maxLines: 7,
                decoration: InputDecoration(
                  hintText: 'Écrivez votre commentaire ici...',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 48,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.send),
                  label: const Text('Envoyer'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 102, 56, 142),
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _envoyerCommentaire,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
