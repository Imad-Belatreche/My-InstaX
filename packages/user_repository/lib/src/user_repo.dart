import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/src/models/my_user.dart';

abstract class UserRepository {
  Stream<User?> get user;

  Future<void> signOut();

  Future<void> signIn(String email, String password);

  Future<MyUserModel> signUp(
    MyUserModel myUser,
    String password,
  );

  Future<void> resetPassword(String email);

  Future<void> setUserData(MyUserModel user);

  Future<MyUserModel> getMyUser(String myUserId);

  Future<String> uploadPicture(String file, String userId);
}
