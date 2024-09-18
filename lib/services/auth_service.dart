import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Verificar se o usuário está logado
  User? get currentUser => _auth.currentUser;

  // Login com email e senha
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Cadastro com email e senha
  Future<User?> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Sign in com Google
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Logout
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  // Verificar se o email foi verificado
  bool isEmailVerified() {
    User? user = _auth.currentUser;
    return user?.emailVerified ?? false;
  }

  // Enviar email de verificação
  Future<void> sendEmailVerification() async {
    User? user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  // Atualizar a selfie do usuário (exemplo de uma possível implementação)
  Future<void> updateSelfieUrl(String selfieUrl) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await user.updatePhotoURL(selfieUrl);
    }
  }
}
