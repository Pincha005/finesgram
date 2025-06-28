import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CommentairePage extends StatefulWidget {
  const CommentairePage({super.key});

  @override
  State<CommentairePage> createState() => _CommentairePageState();
}

class _CommentairePageState extends State<CommentairePage> {
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _sendMail() async {
    final String commentaire = _controller.text.trim();
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'finesgramstudent@gmail.com',
      queryParameters: {
        'subject': 'Commentaire sur Finesgram',
        'body': commentaire,
      },
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Merci pour votre commentaire !')),
      );
      _controller.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Impossible d’ouvrir l’application mail.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Commentaire'),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Laissez-nous un commentaire sur l’application :',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _controller,
                maxLines: 6,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Votre commentaire...',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Veuillez écrire un commentaire.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _sendMail();
                  }
                },
                icon: const Icon(Icons.send),
                label: const Text('Envoyer'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
