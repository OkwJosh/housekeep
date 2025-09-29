import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:housekeep/features/main/seeker/dashboard/controllers/seeker_dashboard_controller.dart';
import 'package:housekeep/features/main/seeker/dashboard/screens/available_keepers.dart';
import 'package:housekeep/features/main/seeker/dashboard/screens/my_jobs.dart';
import 'package:housekeep/features/main/seeker/dashboard/screens/seeker_dashboard.dart';
import 'package:housekeep/features/main/seeker/dashboard/screens/post_job.dart';

// 💡 Rename to SeekerMainShell (more accurate)
class SeekerNavBar extends StatelessWidget {
  const SeekerNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Put controller ONCE at the top level
    final controller = Get.put(SeekerDashboardController());

    final List<Widget> _screens = [
      const SeekerDashboard(),     // Index 0
      PostJobScreen(),       // Index 1 (you imported SeekerBooking, so use it!)
      const AvailableKeepersScreen(),   
      const MyJobsScreen(),      // Index 2
    ];

    return Obx(
      () => Scaffold(
        body: _screens[controller.selectedIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changeTab,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey[600],
          selectedLabelStyle: GoogleFonts.spaceGrotesk(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: GoogleFonts.spaceGrotesk(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              activeIcon: Icon(Icons.add),
              label: 'Post',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group_outlined),
              activeIcon: Icon(Icons.group),
              label: 'Keepers',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.work_history_outlined),
              activeIcon: Icon(Icons.work_history),
              label: 'My Jobs',
            ),
          ],
        ),
      ),
    );
  }
}