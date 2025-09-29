import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:housekeep/utilities/colors.dart'; // Make sure this exists

class PostJobScreen extends StatelessWidget {
  const PostJobScreen({super.key});

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

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Job Title
            TextField(
              decoration: InputDecoration(
                labelText: 'Job Title',
                labelStyle: GoogleFonts.spaceGrotesk(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
                hintText: 'e.g. House Cleaning, Gardening',
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
            TextField(
              enabled: false, // Make it look like a dropdown
              decoration: InputDecoration(
                labelText: 'Service Category',
                labelStyle: GoogleFonts.spaceGrotesk(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
                hintText: 'Select a service',
                hintStyle: GoogleFonts.spaceGrotesk(
                  color: Colors.grey[500],
                  fontSize: 14,
                ),
                filled: true,
                fillColor: Colors.white,
                suffixIcon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.border),
                ),
              ),
              onTap: () {
                // TODO: Show category picker
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Select a service category')),
                );
              },
            ),

            const SizedBox(height: 16),

            // Date & Time
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Preferred Date & Time',
                labelStyle: GoogleFonts.spaceGrotesk(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
                hintText: 'Tap to select date and time',
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
              onTap: () {
                // TODO: Open date/time picker
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Open date picker')),
                );
              },
            ),

            const SizedBox(height: 16),

            // Job Description
            TextField(
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
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Handle job posting
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Job posted successfully!')),
                  );
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Post Job',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
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