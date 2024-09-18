import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    _nameController.text = authProvider.user?.displayName ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aqui você pode adicionar a lógica para atualizar o nome do usuário
                // authProvider.updateUserName(_nameController.text);
                Navigator.pop(context);
              },
              child: const Text('Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }
}
