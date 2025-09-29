import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:housekeep/data/services/auth_services.dart';
import 'package:housekeep/features/main/keeper/keeper_nav_bar.dart';
import 'package:housekeep/features/main/seeker/seeker_nav_bar.dart';


class GoogleSignupScreen extends StatelessWidget {
  final String uid;
  final String? name;
  final String? email;
  final String? photoUrl;

  const GoogleSignupScreen({
    super.key,
    required this.uid,
    this.name,
    this.email,
    this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    final roleController = TextEditingController();
    final phoneController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Complete Profile',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Preview
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey[200],
                backgroundImage: photoUrl != null ? NetworkImage(photoUrl!) : null,
                child: photoUrl == null
                    ? const Icon(Icons.person, size: 40, color: Colors.grey)
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              name ?? 'New User',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Role Selection
            Text(
              'I am a:',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: roleController.text.isEmpty ? null : roleController.text,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
              items: const [
                DropdownMenuItem(value: 'seeker', child: Text('Seeker (Need services)')),
                DropdownMenuItem(value: 'keeper', child: Text('Keeper (Offer services)')),
              ],
              onChanged: (value) {
                roleController.text = value!;
              },
              validator: (value) => value == null ? 'Please select a role' : null,
            ),

            const SizedBox(height: 16),

            // Phone Number
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                labelStyle: GoogleFonts.spaceGrotesk(color: Colors.grey[600]),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),

            const Spacer(),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (roleController.text.isEmpty || phoneController.text.isEmpty) {
                    Get.snackbar('Error', 'Please fill all fields');
                    return;
                  }

                  await Get.find<AuthService>().completeGoogleSignup(
                    uid: uid,
                    role: roleController.text,
                    phone: phoneController.text,
                    name: name,
                    email: email,
                    photoUrl: photoUrl,
                  );

                  // Navigate based on role
                  if (roleController.text == 'keeper') {
                    Get.offAll(const KeeperNavBar());
                  } else {
                    Get.offAll(const SeekerNavBar());
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Continue',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}