import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class RestrictedScreen extends StatelessWidget {
  const RestrictedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (authProvider.user?.isEmailVerified == false) {
      return Scaffold(
        appBar: AppBar(title: const Text('Acesso Restrito')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Seu e-mail não está verificado.'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/verify-email');
                },
                child: const Text('Verificar E-mail'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Área Restrita')),
      body: const Center(
        child: Text('Bem-vindo à área restrita!'),
      ),
    );
  }
}
