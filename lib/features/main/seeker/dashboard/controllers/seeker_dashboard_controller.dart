import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:housekeep/features/main/seeker/dashboard/screens/job_details.dart';

class SeekerDashboardController extends GetxController {
  // Reactive index for bottom navigation
  final selectedIndex = 0.obs;

  // Text controller for search field
  final searchController = TextEditingController();

  // Static data — you can later replace with API calls
  final services = [
    {'name': 'Cleaning', 'icon': Icons.cleaning_services},
    {'name': 'Laundry', 'icon': Icons.local_laundry_service},
    {'name': 'Cooking', 'icon': Icons.restaurant},
    {'name': 'Gardening', 'icon': Icons.yard},
    {'name': 'Repairs', 'icon': Icons.build},
    {'name': 'Pest Control', 'icon': Icons.pest_control},
  ];

  // Add this in your controller class
final myJobs = [
  {
    'id': '1',
    'title': 'Deep House Cleaning',
    'date': 'Sep 30, 2025 • 10:00 AM',
    'location': 'Lekki, Lagos',
    'status': 'Active',
    'icon': Icons.cleaning_services,
  },
  {
    'id': '2',
    'title': 'Garden Maintenance',
    'date': 'Oct 2, 2025 • 2:00 PM',
    'location': 'Ikeja, Lagos',
    'status': 'Completed',
    'icon': Icons.yard,
  },
  {
    'id': '3',
    'title': 'Pest Control Service',
    'date': 'Oct 5, 2025 • 9:00 AM',
    'location': 'Victoria Island',
    'status': 'Cancelled',
    'icon': Icons.pest_control,
  },
];

// Add this method (optional but good practice)
void navigateToJobDetail(Map<String, dynamic> job) {
  Get.to(JobDetailScreen(job: job));
}
  final upcomingBookings = [
    {
      'keeper': 'Sarah Johnson',
      'service': 'House Cleaning',
      'date': 'Sep 30, 2025',
      'time': '10:00 AM',
      'status': 'Confirmed',
    },
    {
      'keeper': 'Michael Brown',
      'service': 'Gardening',
      'date': 'Oct 2, 2025',
      'time': '2:00 PM',
      'status': 'Pending',
    },
  ];

  final popularKeepers = [
    {
      'name': 'Emma Davis',
      'service': 'Cleaning Expert',
      'rating': '4.9',
      'reviews': '234',
      'price': '\$25/hr',
    },
    {
      'name': 'James Wilson',
      'service': 'Multi-service',
      'rating': '4.8',
      'reviews': '189',
      'price': '\$30/hr',
    },
  ];

  final availableKeepers = [
  {
    'name': 'Amina Yusuf',
    'service': 'Cleaning & Laundry',
    'rating': '4.9',
    'reviews': '128',
    'price': '\$22/hr',
  },
  {
    'name': 'Tunde Adeyemi',
    'service': 'Gardening & Repairs',
    'rating': '4.7',
    'reviews': '94',
    'price': '\$28/hr',
  },
  {
    'name': 'Chioma Nwosu',
    'service': 'Cooking & Childcare',
    'rating': '5.0',
    'reviews': '67',
    'price': '\$30/hr',
  },
  {
    'name': 'David Okoro',
    'service': 'Pest Control',
    'rating': '4.8',
    'reviews': '42',
    'price': '\$35/hr',
  },
];

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  // 🔁 Bottom nav tab switcher
  void changeTab(int index) {
    selectedIndex.value = index;
  }

  // 🧭 Navigation methods (replace print with Get.to() later)
  void navigateToSearch() {
    print('Navigate to search');
    // Example: Get.toNamed('/search');
  }

  void navigateToNotifications() {
    print('Navigate to notifications');
    // Example: Get.toNamed('/notifications');
  }

  void navigateToServiceDetail(String service) {
    print('Navigate to service: $service');
  }

  void navigateToBookingDetail(Map<String, dynamic> booking) {
    print('Navigate to booking: ${booking['keeper']}');
  }

  void navigateToKeeperProfile(Map<String, dynamic> keeper) {
    print('Navigate to keeper: ${keeper['name']}');
  }
}