import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:housekeep/features/main/seeker/dashboard/controllers/job_controller.dart';
import 'package:housekeep/utilities/colors.dart';

class PostJobScreen extends StatelessWidget {
  PostJobScreen({super.key});

  final controller = Get.put(PostJobController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Post a Job',
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
        child: ListView(
          children: [
            // Job Title
            TextField(
              controller: controller.titleController,
              decoration: InputDecoration(
                labelText: 'Job Title',
                labelStyle: GoogleFonts.spaceGrotesk(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
                hintText: 'e.g. Deep House Cleaning',
                hintStyle: GoogleFonts.spaceGrotesk(
                  color: Colors.grey[500],
                  fontSize: 14,
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor!),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Category Dropdown
            Obx(
              () => DropdownButtonFormField<String>(
                value: controller.selectedCategory.value,
                decoration: InputDecoration(
                  labelText: 'Service Category',
                  labelStyle: GoogleFonts.spaceGrotesk(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Theme.of(context).primaryColor!),
                  ),
                ),
                items: controller.categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(
                      category,
                      style: GoogleFonts.spaceGrotesk(fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (value) => controller.selectedCategory.value = value!,
              ),
            ),

            const SizedBox(height: 16),

            // Date Picker
            Obx(
              () => TextField(
                readOnly: true,
                controller: TextEditingController(
                  text: controller.selectedDate.value == null
                      ? ''
                      : '${controller.selectedDate.value!.day}/${controller.selectedDate.value!.month}/${controller.selectedDate.value!.year}',
                ),
                decoration: InputDecoration(
                  labelText: 'Preferred Date',
                  labelStyle: GoogleFonts.spaceGrotesk(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                  hintText: 'Tap to select date',
                  hintStyle: GoogleFonts.spaceGrotesk(
                    color: Colors.grey[500],
                    fontSize: 14,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.calendar_today, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                ),
                onTap: controller.pickDate,
              ),
            ),

            const SizedBox(height: 16),

            // Time Picker
            Obx(
              () => TextField(
                readOnly: true,
                controller: TextEditingController(
                  text: controller.selectedTime.value == null
                      ? ''
                      : controller.selectedTime.value!.format(context),
                ),
                decoration: InputDecoration(
                  labelText: 'Preferred Time',
                  labelStyle: GoogleFonts.spaceGrotesk(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                  hintText: 'Tap to select time',
                  hintStyle: GoogleFonts.spaceGrotesk(
                    color: Colors.grey[500],
                    fontSize: 14,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.access_time, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                ),
                onTap: controller.pickTime,
              ),
            ),

            const SizedBox(height: 16),

            // Duration
            Obx(
              () => DropdownButtonFormField<String>(
                value: controller.selectedDuration.value.isEmpty
                    ? null
                    : controller.selectedDuration.value,
                decoration: InputDecoration(
                  labelText: 'Estimated Duration',
                  labelStyle: GoogleFonts.spaceGrotesk(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                ),
                items: controller.durations.map((duration) {
                  return DropdownMenuItem(
                    value: duration,
                    child: Text(
                      duration,
                      style: GoogleFonts.spaceGrotesk(fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (value) => controller.selectedDuration.value = value!,
              ),
            ),

            const SizedBox(height: 16),

            // Job Description
            TextField(
              controller: controller.descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Job Description',
                labelStyle: GoogleFonts.spaceGrotesk(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
                hintText: 'Describe what needs to be done, location, special instructions...',
                hintStyle: GoogleFonts.spaceGrotesk(
                  color: Colors.grey[500],
                  fontSize: 14,
                ),
                filled: true,
                fillColor: Colors.white,
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.border),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Post Job Button
            Obx(
              () => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.isPosting.value
                      ? null
                      : controller.postJob,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: controller.isPosting.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'Post Job',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
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