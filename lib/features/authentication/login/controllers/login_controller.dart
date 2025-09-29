import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:housekeep/features/authentication/signup/screens/sign_up.dart';
import 'package:housekeep/features/main/keeper/keeper_nav_bar.dart';
import 'package:housekeep/features/main/seeker/dashboard/screens/seeker_dashboard.dart';
import 'package:housekeep/features/main/seeker/seeker_nav_bar.dart';


class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final obscurePassword = true.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void handleLogin() {
    if (formKey.currentState!.validate()) {
      // Handle login logic here

      Get.offAll(() => SeekerNavbar());
    }
  }

  void handleGoogleSignIn() {
    // Handle Google sign-in logic here
    print('Google Sign-In clicked');
  }

  void navigateToSignUp() {
    Get.to(() => const SignUpScreen());
  }

  void navigateToForgotPassword() {
    // Navigate to forgot password
    print('Forgot password clicked');
  }
}