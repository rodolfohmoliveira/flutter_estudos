import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Verificar E-mail')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Seu e-mail não está verificado. Por favor, verifique seu e-mail para continuar.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await authProvider.sendEmailVerification();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('E-mail de verificação enviado')));
              },
              child: const Text('Enviar E-mail de Verificação'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                authProvider.checkLoginStatus();  // Atualizar o status de verificação
                Navigator.pop(context);
              },
              child: const Text('Já Verifiquei'),
            ),
          ],
        ),
      ),
    );
  }
}
