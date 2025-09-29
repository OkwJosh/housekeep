import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:housekeep/features/main/seeker/dashboard/controllers/seeker_dashboard_controller.dart';
import 'package:housekeep/utilities/colors.dart';

class AvailableKeepersScreen extends StatelessWidget {
  const AvailableKeepersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SeekerDashboardController>();
    final keepers = controller.availableKeepers;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Available Keepers',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: keepers.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 60, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No keepers available right now',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 10, bottom: 30),
                itemCount: keepers.length,
                itemBuilder: (context, index) {
                  final keeper = keepers[index];
                  return GestureDetector(
                    onTap: () => controller.navigateToKeeperProfile(keeper),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          // Avatar
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Icon(Icons.person, size: 32, color: Colors.grey[400]),
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  keeper['name'] as String,
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  keeper['service'] as String,
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.star, size: 16, color: Colors.amber),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${keeper['rating']} (${keeper['reviews']} reviews)',
                                      style: GoogleFonts.spaceGrotesk(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // "Send Request" Button (replaces price)
                          SizedBox(
                            width: 90,
                            child: ElevatedButton(
                              onPressed: () {
                                // TODO: Handle send request logic
                                Get.snackbar(
                                  'Request Sent',
                                  'Booking request sent to ${keeper['name']}',
                                  backgroundColor: Theme.of(context).primaryColor,
                                  colorText: Colors.white,
                                );
                                // Optional: Navigate to job details or confirmation
                                // controller.sendBookingRequest(keeper);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                'Send Request',
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}