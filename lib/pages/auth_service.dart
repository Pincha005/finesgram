import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Vérifie si un email existe déjà
  Future<bool> checkEmailExists(String email) async {
    try {
      final methods = await _auth.fetchSignInMethodsForEmail(email);
      return methods.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  // Inscription utilisateur
  Future<User?> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Optionnel : mettre à jour le displayName
      await result.user?.updateDisplayName(name);
      return result.user;
    } catch (e) {
      rethrow;
    }
  }
}
