import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Adicionar documento à coleção 'home'
  Future<void> addHomeDocument(Map<String, dynamic> data) async {
    try {
      await _db.collection('home').add(data);
    } catch (e) {
      print(e);
    }
  }

  // Adicionar documento à coleção 'restricted'
  Future<void> addRestrictedDocument(Map<String, dynamic> data) async {
    User? user = _auth.currentUser;

    // Somente usuários com e-mail verificado podem adicionar documentos à coleção 'restricted'
    if (user != null && user.emailVerified) {
      try {
        await _db.collection('restricted').add(data);
      } catch (e) {
        print(e);
      }
    } else {
      throw Exception("Usuário não tem permissão para adicionar documentos à coleção 'restricted'");
    }
  }

  // Obter todos os documentos da coleção 'home'
  Stream<List<Map<String, dynamic>>> getHomeDocuments() {
    return _db.collection('home').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  // Obter todos os documentos da coleção 'restricted' (apenas para usuários com e-mail verificado)
  Stream<List<Map<String, dynamic>>> getRestrictedDocuments() {
    User? user = _auth.currentUser;

    if (user != null && user.emailVerified) {
      return _db.collection('restricted').snapshots().map((snapshot) {
        return snapshot.docs.map((doc) => doc.data()).toList();
      });
    } else {
      throw Exception("Usuário não tem permissão para acessar a coleção 'restricted'");
    }
  }

  // Atualizar documento da coleção 'home'
  Future<void> updateHomeDocument(String docId, Map<String, dynamic> data) async {
    try {
      await _db.collection('home').doc(docId).update(data);
    } catch (e) {
      print(e);
    }
  }

  // Atualizar documento da coleção 'restricted' (apenas para usuários com e-mail verificado)
  Future<void> updateRestrictedDocument(String docId, Map<String, dynamic> data) async {
    User? user = _auth.currentUser;

    if (user != null && user.emailVerified) {
      try {
        await _db.collection('restricted').doc(docId).update(data);
      } catch (e) {
        print(e);
      }
    } else {
      throw Exception("Usuário não tem permissão para editar a coleção 'restricted'");
    }
  }

  // Remover documento de qualquer coleção
  Future<void> deleteDocument(String collection, String docId) async {
    try {
      await _db.collection(collection).doc(docId).delete();
    } catch (e) {
      print(e);
    }
  }
}
