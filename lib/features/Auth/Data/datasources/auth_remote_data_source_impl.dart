import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  })  : firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Stream<User?> authStateChanges() {
    return firebaseAuth.authStateChanges();
  }

  @override
  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }

  @override
  Future<UserCredential> login({
    required String email,
    required String password,
  }) {
    return firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) {
    return firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logout() {
    return firebaseAuth.signOut();
  }

  @override
  Future<void> resetPassword({required String email}) {
    return firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> updatePassword({required String newPassword}) async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'no-current-user',
        message: 'No authenticated user found.',
      );
    }
    await user.updatePassword(newPassword);
  }

  @override
  Future<void> deleteAccount() async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'no-current-user',
        message: 'No authenticated user found.',
      );
    }

    final userDocRef = firestore.collection('users').doc(user.uid);

    await userDocRef.set({
      'accountStatus': 'deleted',
      'deletedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    try {
      await user.delete();
    } catch (e) {
      await userDocRef.set({
        'accountStatus': 'active',
        'deletedAt': FieldValue.delete(),
      }, SetOptions(merge: true));
      rethrow;
    }
  }

  @override
  Future<void> saveUserData({required UserModel user}) {
    return firestore
        .collection('users')
        .doc(user.id)
        .set(user.toJson(), SetOptions(merge: true));
  }

  @override
  Future<void> updateUserData({required UserModel user}) {
    final data = user.toJson()
      ..removeWhere((key, value) => value == null)
      ..remove('id')
      ..remove('createdAt');
    return firestore
        .collection('users')
        .doc(user.id)
        .set(data, SetOptions(merge: true));
  }

  @override
  Future<UserModel?> getUserData({required String userId}) async {
    final doc = await firestore.collection('users').doc(userId).get();
    if (!doc.exists || doc.data() == null) return null;
    return UserModel.fromJson(doc.data()!);
  }

  @override
  Future<UserCredential> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login(
      permissions: ['email', 'public_profile'],
    );

    if (loginResult.status == LoginStatus.cancelled) {
      throw FirebaseAuthException(
        code: 'facebook-sign-in-canceled',
        message: 'Facebook login was canceled by user.',
      );
    }

    if (loginResult.status != LoginStatus.success || loginResult.accessToken == null) {
      throw FirebaseAuthException(
        code: 'facebook-sign-in-failed',
        message: loginResult.message ?? 'Facebook login failed.',
      );
    }

    final OAuthCredential credential = FacebookAuthProvider.credential(
      loginResult.accessToken!.tokenString,
    );
    return firebaseAuth.signInWithCredential(credential);
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn.instance
        .authenticate(scopeHint: ['email']);
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );
    return firebaseAuth.signInWithCredential(credential);
  }
}

