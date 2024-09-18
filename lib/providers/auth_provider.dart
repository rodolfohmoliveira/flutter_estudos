import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  UserModel? _user;

  UserModel? get user => _user;

  Future<void> checkLoginStatus() async {
    User? firebaseUser = _authService.currentUser;
    if (firebaseUser != null) {
      _user = UserModel.fromFirebaseUser(firebaseUser);
      notifyListeners();
    }
  }

  Future<bool> login(String email, String password) async {
    User? firebaseUser = await _authService.signInWithEmailAndPassword(email, password);
    if (firebaseUser != null) {
      _user = UserModel.fromFirebaseUser(firebaseUser);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> register(String email, String password) async {
    User? firebaseUser = await _authService.registerWithEmailAndPassword(email, password);
    if (firebaseUser != null) {
      _user = UserModel.fromFirebaseUser(firebaseUser);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> loginWithGoogle() async {
    User? firebaseUser = await _authService.signInWithGoogle();
    if (firebaseUser != null) {
      _user = UserModel.fromFirebaseUser(firebaseUser);
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _authService.signOut();
    _user = null;
    notifyListeners();
  }

  Future<String?> uploadSelfie(File image) async {
    try {
      final user = _authService.currentUser;
      if (user != null) {
        final storageRef = FirebaseStorage.instance.ref().child('selfies/${user.uid}.jpg');
        await storageRef.putFile(image);
        final imageUrl = await storageRef.getDownloadURL();
        return imageUrl;
      }
    } catch (e) {
      print('Error uploading selfie: $e');
    }
    return null;
  }

  Future<void> updateSelfieUrl(String selfieUrl) async {
    User? firebaseUser = _authService.currentUser;
    if (firebaseUser != null) {
      await _authService.updateSelfieUrl(selfieUrl);
      _user = UserModel.fromFirebaseUser(firebaseUser);
      notifyListeners();
    }
  }

  Future<void> sendEmailVerification() async {
    User? firebaseUser = _authService.currentUser;
    if (firebaseUser != null && !firebaseUser.emailVerified) {
      await _authService.sendEmailVerification();
    }
  }
}
