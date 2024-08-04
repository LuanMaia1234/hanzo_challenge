import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/user_model.dart';
import 'auth_data_source.dart';

class FirebaseAuthDataSourceImpl implements AuthDataSource {
  final FirebaseAuth _auth;

  FirebaseAuthDataSourceImpl(this._auth);

  @override
  Future<UserModel> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user == null) throw ServerException();
      return UserModel.fromFirebaseAuthUser(result.user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw ExistedAccountException();
      }
      if (e.code == 'weak-password') {
        throw WeekPasswordException();
      }
      throw ServerException();
    }
  }

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user == null) throw ServerException();
      return UserModel.fromFirebaseAuthUser(result.user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        throw InvalidCredentialException();
      }
      throw ServerException();
    }
  }

  @override
  Future<UserModel> getLoggedUser() async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) throw ServerException();
    return UserModel.fromFirebaseAuthUser(currentUser);
  }

  @override
  Future<void> signOut() async {
    return await _auth.signOut();
  }
}
