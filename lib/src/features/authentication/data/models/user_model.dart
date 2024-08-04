import 'package:firebase_auth/firebase_auth.dart';
import 'package:hanzo_challenge/src/features/authentication/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
  });

  factory UserModel.fromFirebaseAuthUser(User firebaseAuthUser) {
    return UserModel(
      id: firebaseAuthUser.uid,
      name: firebaseAuthUser.displayName,
      email: firebaseAuthUser.email,
    );
  }
}
