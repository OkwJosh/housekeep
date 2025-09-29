import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:housekeep/features/main/keeper/dashboard/screens/keeper_dashboard.dart';


class SignUpController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final obscurePassword = true.obs;
  final obscureConfirmPassword = true.obs;
  final acceptTerms = false.obs;
  final userType = 'seeker'.obs; // 'seeker' or 'keeper'

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  void toggleAcceptTerms(bool? value) {
    acceptTerms.value = value ?? false;
  }

  void selectUserType(String type) {
    userType.value = type;
  }

  void handleSignUp() {
    if (!acceptTerms.value) {
      Get.snackbar(
        'Terms & Conditions',
        'Please accept the terms and conditions',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
       
      return;
    }

    if (formKey.currentState!.validate()) {
      // Handle signup logic here
      print('Name: ${nameController.text}');
      print('Email: ${emailController.text}');
      print('Password: ${passwordController.text}');
      print('User Type: ${userType.value}');
      // Example: Get.offAll(() => HomeScreen());
      Get.offAll(() => KeeperDashboard());
    }
  }

  void handleGoogleSignUp() {
    // Handle Google sign-up logic here
    print('Google Sign-Up clicked');
  }

  void navigateToLogin() {
    Get.back();
  }

  void navigateToTerms() {
    print('Terms and Conditions clicked');
  }
}
