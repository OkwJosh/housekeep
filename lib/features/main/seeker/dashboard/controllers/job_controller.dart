import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housekeep/data/models/job_model.dart';
import 'package:housekeep/data/services/auth_services.dart';
import 'package:housekeep/data/services/job_services.dart';


class PostJobController extends GetxController {
  final JobService _jobService = Get.find<JobService>();
  final AuthService _authService = Get.find<AuthService>();

  // Form controllers
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  // Reactive fields
  var selectedCategory = 'Cleaning'.obs;
  var selectedDate = Rx<DateTime?>(null);
  var selectedTime = Rx<TimeOfDay?>(null);
  var selectedDuration = ''.obs;
  var isPosting = false.obs;

  // Options
  final categories = [
    'Cleaning',
    'Laundry',
    'Cooking',
    'Gardening',
    'Repairs',
    'Pest Control',
  ].obs;

  final durations = [
    '1 hour',
    '2 hours',
    '3 hours',
    '4 hours',
    'Full day',
  ].obs;

  // Date/Time pickers
  void pickDate() async {
    final date = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (date != null) selectedDate.value = date;
  }

  void pickTime() async {
    final time = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) selectedTime.value = time;
  }

  // Post job
  Future<void> postJob() async {
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        selectedDate.value == null ||
        selectedTime.value == null ||
        selectedDuration.value.isEmpty) {
      Get.snackbar('Error', 'Please fill all required fields');
      return;
    }

    isPosting.value = true;
    try {
      final job = Job(
        id: '',
        seekerId: _authService.currentUser!.uid,
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        location: 'Lekki, Lagos', // TODO: Get from profile
        date: selectedDate.value!,
        time: selectedTime.value!.format(Get.context!),
        duration: selectedDuration.value,
        price: '\$50', // TODO: Add price logic
        status: 'open',
        applicants: [],
      );

      await _jobService.postJob(job);
      Get.snackbar('Success', 'Job posted successfully!');
      Get.back(); // Go back to dashboard
    } finally {
      isPosting.value = false;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}