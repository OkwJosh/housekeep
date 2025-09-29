import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:housekeep/common/appbar/custom_appbar.dart';
import 'package:housekeep/features/authentication/signup/controllers/sign_up_controller.dart';
import 'package:housekeep/utilities/colors.dart';


class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());

    return Scaffold(
      appBar: CustomAppbar(
        title: 'HouseKeep',
        centerTitle: false,
        titleStyle: GoogleFonts.spaceGrotesk(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 25, left: 15, right: 15),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Account',
                  style: GoogleFonts.spaceGrotesk(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'Sign up to get started',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 25),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'I want to',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Obx(
                      () => Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => controller.selectUserType('seeker'),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: controller.userType.value == 'seeker'
                                      ? Theme.of(context).primaryColor.withOpacity(0.1)
                                      : AppColors.secondary,
                                  border: Border.all(
                                    color: controller.userType.value == 'seeker'
                                        ? Theme.of(context).primaryColor
                                        : AppColors.border,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.search,
                                      size: 32,
                                      color: controller.userType.value == 'seeker'
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey[600],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Find a Keeper',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.spaceGrotesk(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: controller.userType.value == 'seeker'
                                            ? Theme.of(context).primaryColor
                                            : Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Seeker',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.spaceGrotesk(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => controller.selectUserType('keeper'),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: controller.userType.value == 'keeper'
                                      ? Theme.of(context).primaryColor.withOpacity(0.1)
                                      : AppColors.secondary,
                                  border: Border.all(
                                    color: controller.userType.value == 'keeper'
                                        ? Theme.of(context).primaryColor
                                        : AppColors.border,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.home_work,
                                      size: 32,
                                      color: controller.userType.value == 'keeper'
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey[600],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Offer Services',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.spaceGrotesk(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: controller.userType.value == 'keeper'
                                            ? Theme.of(context).primaryColor
                                            : Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Keeper',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.spaceGrotesk(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Full Name',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: controller.nameController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        if (value.length < 3) {
                          return 'Name must be at least 3 characters';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'John Doe',
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 15,
                        ),
                        hintStyle: GoogleFonts.spaceGrotesk(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!GetUtils.isEmail(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'name@example.com',
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 15,
                        ),
                        hintStyle: GoogleFonts.spaceGrotesk(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Obx(
                      () => TextFormField(
                        controller: controller.passwordController,
                        obscureText: controller.obscurePassword.value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 15,
                          ),
                          hintStyle: GoogleFonts.spaceGrotesk(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.obscurePassword.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: controller.togglePasswordVisibility,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Confirm Password',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Obx(
                      () => TextFormField(
                        controller: controller.confirmPasswordController,
                        obscureText: controller.obscureConfirmPassword.value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != controller.passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Re-enter your password',
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 15,
                          ),
                          hintStyle: GoogleFonts.spaceGrotesk(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.obscureConfirmPassword.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed:
                                controller.toggleConfirmPasswordVisibility,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Obx(
                  () => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: controller.acceptTerms.value,
                        onChanged: controller.toggleAcceptTerms,
                        activeColor: Theme.of(context).primaryColor,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: GestureDetector(
                            onTap: controller.navigateToTerms,
                            child: RichText(
                              text: TextSpan(
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                                children: [
                                  const TextSpan(text: 'I agree to the '),
                                  TextSpan(
                                    text: 'Terms & Conditions',
                                    style: GoogleFonts.spaceGrotesk(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: controller.handleSignUp,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: controller.handleGoogleSignUp,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      side: BorderSide(color: AppColors.border, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/logos/google.png',
                          height: 20,
                          width: 20,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Continue with Google',
                          style: GoogleFonts.spaceGrotesk(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.navigateToLogin,
                      child: Text(
                        'Login',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 14,
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}