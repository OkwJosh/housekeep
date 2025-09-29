import 'package:flutter/material.dart';
import 'package:get/get.dart';




class KeeperDashboardController extends GetxController {
  final selectedIndex = 0.obs;
  final isAvailable = true.obs;

  final todayStats = {
    'bookings': '5',
    'earnings': '\$250',
    'hours': '8.5',
    'rating': '4.9',
  };

  final pendingRequests = [
    {
      'client': 'Alice Cooper',
      'service': 'House Cleaning',
      'date': 'Sep 30, 2025',
      'time': '10:00 AM',
      'duration': '3 hours',
      'price': '\$75',
      'location': '123 Main St',
      'image': 'assets/client1.png',
    },
    {
      'client': 'Bob Martin',
      'service': 'Gardening',
      'date': 'Oct 1, 2025',
      'time': '2:00 PM',
      'duration': '2 hours',
      'price': '\$50',
      'location': '456 Oak Ave',
      'image': 'assets/client2.png',
    },
  ];

  final upcomingJobs = [
    {
      'client': 'Sarah Wilson',
      'service': 'Deep Cleaning',
      'date': 'Sep 29, 2025',
      'time': '3:00 PM',
      'status': 'Confirmed',
      'price': '\$100',
      'image': 'assets/client3.png',
    },
    {
      'client': 'Tom Harris',
      'service': 'Laundry Service',
      'date': 'Sep 30, 2025',
      'time': '11:00 AM',
      'status': 'In Progress',
      'price': '\$40',
      'image': 'assets/client4.png',
    },
  ];

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  void toggleAvailability() {
    isAvailable.value = !isAvailable.value;
    Get.snackbar(
      'Availability Updated',
      isAvailable.value ? 'You are now available for bookings' : 'You are now unavailable',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isAvailable.value ? Colors.green : Colors.orange,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  void navigateToNotifications() {
    print('Navigate to notifications');
  }

  void acceptRequest(Map<String, dynamic> request) {
    Get.snackbar(
      'Request Accepted',
      'Booking with ${request['client']} has been accepted',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void rejectRequest(Map<String, dynamic> request) {
    Get.snackbar(
      'Request Rejected',
      'Booking with ${request['client']} has been rejected',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  void navigateToJobDetail(Map<String, dynamic> job) {
    print('Navigate to job: ${job['client']}');
  }

  void navigateToRequestDetail(Map<String, dynamic> request) {
    print('Navigate to request: ${request['client']}');
  }
}