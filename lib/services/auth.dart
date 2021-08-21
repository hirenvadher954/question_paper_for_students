import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  AppUser({required this.uid});

  final String uid;
}

abstract class AuthBase {
  Future<AppUser?> currentUser();

  Future<AppUser?> signInAnonymously();

  Future<void> logout();
}

class Auth implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AppUser? _userFromFirebase(User? user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  @override
  Future<AppUser?> currentUser() async {
    final user = _firebaseAuth.currentUser;
    return _userFromFirebase(user);
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
    _userFromFirebase(null);
  }

  @override
  Future<AppUser?> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }
}
