import '../models/user_model.dart';

abstract class AuthDataSource {
  Future<UserModel> signUp({
    required String email,
    required String password,
  });

  Future<UserModel> signIn({
    required String email,
    required String password,
  });

  Future<UserModel> getLoggedUser();

  Future<void> signOut();
}
