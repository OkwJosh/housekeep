import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:housekeep/features/authentication/login/screens/login.dart';
import 'package:housekeep/features/main/seeker/dashboard/screens/edit_profile.dart';
import 'package:housekeep/utilities/colors.dart';

class SeekerSettingsScreen extends StatelessWidget {
  const SeekerSettingsScreen({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Log Out',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        content: Text(
          'Are you sure you want to log out?',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Clear auth and navigate to login
              Get.offAll(()=>LoginScreen());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Log Out',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Settings',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: [
          // 👤 Profile Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.person, size: 32, color: Colors.grey),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'John Doe', // TODO: Replace with real user name
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'johndoe@example.com', // TODO: Real email
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[500]),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 🔧 Account Settings
          _buildSectionTitle('Account'),
          _buildSettingItem(
            context,
            icon: Icons.edit_outlined,
            title: 'Edit Profile',
            onTap: () {
              Get.to(()=> EditProfileScreen());
            },
          ),
          _buildSettingItem(
            context,
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            onTap: () {
              Get.snackbar('Info', 'Notification Settings');
            },
          ),
          _buildSettingItem(
            context,
            icon: Icons.lock_outline,
            title: 'Privacy & Security',
            onTap: () {
              Get.snackbar('Info', 'Privacy Settings');
            },
          ),

          const SizedBox(height: 20),

          // ⚖️ Legal
          _buildSectionTitle('Legal'),
          _buildSettingItem(
            context,
            icon: Icons.description_outlined,
            title: 'Terms of Service',
            onTap: () {
              Get.snackbar('Info', 'Terms of Service');
            },
          ),
          _buildSettingItem(
            context,
            icon: Icons.policy_outlined,
            title: 'Privacy Policy',
            onTap: () {
              Get.snackbar('Info', 'Privacy Policy');
            },
          ),

          const SizedBox(height: 30),

          // 🔌 Logout Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => _showLogoutDialog(context),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                foregroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Log Out',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: GoogleFonts.spaceGrotesk(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).primaryColor, size: 20),
            const SizedBox(width: 16),
            Text(
              title,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey[500]),
          ],
        ),
      ),
    );
  }
}