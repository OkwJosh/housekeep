// lib/features/authentication/login/controllers/login_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:housekeep/data/services/auth_services.dart';
import 'package:housekeep/features/authentication/google_auth_screen.dart';
import 'package:housekeep/features/main/keeper/keeper_nav_bar.dart';
import 'package:housekeep/features/main/seeker/seeker_nav_bar.dart';
import 'package:housekeep/features/authentication/signup/screens/sign_up.dart';


class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final obscurePassword = true.obs;

  final AuthService _authService = Get.find<AuthService>();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  // 🔑 Email/Password Login
  Future<void> handleLogin() async {
    if (formKey.currentState!.validate()) {
      String? error = await _authService.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (error == null) {
        // ✅ Login success → check role and navigate
        await _navigateByUserRole();
      } else {
        Get.snackbar('Login Failed', error);
      }
    }
  }

  // 🔑 Google Sign-In
  Future<void> handleGoogleSignIn() async {
    final result = await _authService.signInWithGoogle();

    if (result.error != null) {
      Get.snackbar('Google Sign-In Failed', result.error!);
      return;
    }

    if (result.isNewUser) {
      // 👉 New or incomplete user → complete profile
      Get.to(GoogleSignupScreen(
        uid: result.uid!,
        name: result.name,
        email: result.email,
        photoUrl: result.photoUrl,
      ));
    } else {
      // 👉 Existing user → go to dashboard
      if (result.role == 'keeper') {
        Get.offAll(const KeeperNavBar());
      } else {
        Get.offAll(const SeekerNavBar());
      }
    }
  }

  // 🧭 Navigate based on user role (for email login)
  Future<void> _navigateByUserRole() async {
    try {
      final user = _authService.currentUser!;
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (!userData.exists) {
        Get.snackbar('Error', 'User profile not found');
        return;
      }

      final role = userData['role'] as String?;
      if (role == 'keeper') {
        Get.offAll(const KeeperNavBar());
      } else {
        Get.offAll(const SeekerNavBar());
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load user profile');
    }
  }

  void navigateToSignUp() {
    Get.to(const SignUpScreen());
  }

  void navigateToForgotPassword() {
    Get.snackbar('Info', 'Forgot password not implemented yet');
    // TODO: Implement forgot password screen
  }
}