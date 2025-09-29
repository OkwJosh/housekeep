import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  // Get current user
  User? get currentUser => _auth.currentUser;

  // ─── EMAIL/PASSWORD SIGN UP ───────────────────────────────
  Future<String?> signUp({
    required String email,
    required String password,
    required String name,
    required String role,
    String? phone,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Update display name in Firebase Auth
      await result.user!.updateDisplayName(name);

      // Save full profile to Firestore
      await _firestore.collection('users').doc(result.user!.uid).set({
        'name': name,
        'email': email.trim(),
        'phone': phone,
        'role': role,
        'photoUrl': null,
        'isGoogleUser': false,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return null; // Success
    } catch (e) {
      return _handleFirebaseAuthError(e);
    }
  }

  // ─── EMAIL/PASSWORD LOGIN ─────────────────────────────────
  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return null; // Success
    } catch (e) {
      return _handleFirebaseAuthError(e);
    }
  }

  // ─── GOOGLE SIGN-IN ───────────────────────────────────────
  Future<GoogleSignInResult> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return GoogleSignInResult(error: 'Sign in cancelled');
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      bool isNewUser = userCredential.additionalUserInfo!.isNewUser;

      // Check if user exists in Firestore and has a role
      final userData = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      // If user exists but has no role → treat as incomplete (needs signup)
      if (userData.exists && userData['role'] != null) {
        isNewUser = false;
      } else {
        isNewUser = true;
      }

      return GoogleSignInResult(
        isNewUser: isNewUser,
        uid: userCredential.user!.uid,
        name: userCredential.user!.displayName,
        email: userCredential.user!.email,
        photoUrl: userCredential.user!.photoURL,
        role: userData.exists ? userData['role'] : null,
      );
    } catch (e) {
      return GoogleSignInResult(error: _handleFirebaseAuthError(e));
    }
  }

  // ─── COMPLETE GOOGLE SIGNUP (AFTER ROLE SELECTION) ───────
  Future<void> completeGoogleSignup({
    required String uid,
    required String role,
    required String phone,
    String? name,
    String? email,
    String? photoUrl,
  }) async {
    await _firestore.collection('users').doc(uid).set({
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'photoUrl': photoUrl,
      'isGoogleUser': true,
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // ─── LOGOUT ───────────────────────────────────────────────
  Future<void> logout() async {
    await _googleSignIn.signOut(); // Sign out from Google
    await _auth.signOut();         // Sign out from Firebase
    Get.offAllNamed('/login');
  }

  // ─── ERROR HANDLING ───────────────────────────────────────
  String _handleFirebaseAuthError(Object e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'invalid-email':
          return 'Invalid email address';
        case 'user-disabled':
          return 'This user has been disabled';
        case 'user-not-found':
          return 'No user found with this email';
        case 'wrong-password':
          return 'Wrong password';
        case 'email-already-in-use':
          return 'Email already in use';
        case 'operation-not-allowed':
          return 'Operation not allowed';
        case 'weak-password':
          return 'Password is too weak';
        default:
          return 'An error occurred: ${e.message}';
      }
    }
    return e.toString();
  }
}

// ─── GOOGLE SIGN-IN RESULT ─────────────────────────────────
class GoogleSignInResult {
  final bool isNewUser;
  final String? uid;
  final String? name;
  final String? email;
  final String? photoUrl;
  final String? role;
  final String? error;

  GoogleSignInResult({
    this.isNewUser = false,
    this.uid,
    this.name,
    this.email,
    this.photoUrl,
    this.role,
    this.error,
  });
}