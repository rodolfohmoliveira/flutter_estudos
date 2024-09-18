import 'package:flutter/material.dart';
import 'package:desafio_capyba2/screens/auth/login_screen.dart';
import 'package:desafio_capyba2/screens/home/home_screen.dart';
import 'package:desafio_capyba2/screens/profile/profile_screen.dart';
import 'package:desafio_capyba2/screens/auth/selfie_screen.dart';
import 'package:desafio_capyba2/screens/email_verification/verify_email_screen.dart';

class App extends StatelessWidget {
  final bool loggedIn;

  const App({super.key, required this.loggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Desafio Capyba2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: loggedIn ? '/home' : '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SelfieScreen(), // Tela de cadastro com selfie
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/verify-email': (context) => const VerifyEmailScreen(),
      },
    );
  }
}
