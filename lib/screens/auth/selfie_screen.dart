import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class SelfieScreen extends StatefulWidget {
  const SelfieScreen({super.key});

  @override
  _SelfieScreenState createState() => _SelfieScreenState();
}

class _SelfieScreenState extends State<SelfieScreen> {
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadSelfie() async {
    if (_image != null) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final selfieUrl = await authProvider.uploadSelfie(_image!);
      if (selfieUrl != null) {
        await authProvider.updateSelfieUrl(selfieUrl);
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Falha ao enviar a selfie')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Por favor, tire uma selfie')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tirar Selfie')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null
                ? const Text('Nenhuma imagem selecionada.')
                : Image.file(_image!),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Tirar Selfie'),
            ),
            ElevatedButton(
              onPressed: _uploadSelfie,
              child: const Text('Confirmar'),
            ),
          ],
        ),
      ),
    );
  }
}
