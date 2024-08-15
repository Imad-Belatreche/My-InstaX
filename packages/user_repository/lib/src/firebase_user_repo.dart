import 'dart:developer' show log;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/src/entities/entities.dart';
import 'package:user_repository/src/models/my_user.dart';
import 'package:user_repository/src/user_repo.dart';

class FirebaseUserRepository implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final userCollection = FirebaseFirestore.instance.collection('users');

  FirebaseUserRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  // Sign up
  @override
  Future<MyUserModel> signUp(MyUserModel myUser, String password) async {
    try {
      final createdUser = await _firebaseAuth.createUserWithEmailAndPassword(
        email: myUser.email,
        password: password,
      );
      myUser = myUser.copyWith(
        id: createdUser.user!.uid,
      );
      return myUser;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // Log in
  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // Reset password
  @override
  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(
      email: email,
    );
  }

  // Sign out
  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // Fetch user data
  @override
  Future<MyUserModel> getMyUser(String myUserId) async {
    try {
      return await userCollection.doc(myUserId).get().then(
        (value) {
          return MyUserModel.fromEntity(
              MyUserEntite.fromDocument(value.data()!));
        },
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // Set user data
  @override
  Future<void> setUserData(MyUserModel user) async {
    try {
      await userCollection.doc(user.id).set(user.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Stream<User?> get user => _firebaseAuth.authStateChanges().map(
        (firebaseUser) {
          return firebaseUser;
        },
      );
}
