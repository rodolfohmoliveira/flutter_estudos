class UserModel {
  final String uid;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final bool isEmailVerified;

  UserModel({
    required this.uid,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.isEmailVerified = false,
  });

  // Converter de Firebase User para UserModel
  factory UserModel.fromFirebaseUser(user) {
    return UserModel(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
      isEmailVerified: user.emailVerified,
    );
  }

  // Converter para Map (se precisar enviar para Firestore)
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'isEmailVerified': isEmailVerified,
    };
  }

  // Converter de Map (se recuperar de Firestore)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      displayName: map['displayName'],
      photoUrl: map['photoUrl'],
      isEmailVerified: map['isEmailVerified'],
    );
  }
}
