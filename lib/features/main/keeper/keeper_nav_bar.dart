import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:housekeep/features/main/keeper/dashboard/controllers/keeper_dashboard_controller.dart';
import 'package:housekeep/features/main/keeper/dashboard/screens/keeper_dashboard.dart';
import 'package:housekeep/features/main/keeper/jobs/screens/keeper_job.dart';
import 'package:housekeep/features/main/keeper/requests/screens/requests.dart';

class KeeperNavBar extends StatelessWidget {
  const KeeperNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Put controller ONCE at the top
    final controller = Get.put(KeeperDashboardController());

    // ✅ 4 screens for 4 tabs
    final List<Widget> _screens = [
      const KeeperDashboard(),       // Index 0 → Home
      const AvailableJobsScreen(),      // Index 1 → Jobs
      const RequestsScreen(),  // Index 2 → Messages
      // const Placeholder(),   // Index 3 → Profile
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
              icon: Icon(Icons.work_outline),
              activeIcon: Icon(Icons.work),
              label: 'Jobs',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              activeIcon: Icon(Icons.calendar_today),
              label: 'Requests',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.person_outline),
            //   activeIcon: Icon(Icons.person),
            //   label: 'Profile',
            // ),
          ],
        ),
      ),
    );
  }
}