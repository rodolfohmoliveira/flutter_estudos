import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:desafio_capyba2/config/firebase_options.dart';
import 'package:desafio_capyba2/app.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(home: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return const App(loggedIn: true);  // Usuário logado
        } else {
          return const App(loggedIn: false); // Usuário não logado
        }
      },
    );
  }
}
