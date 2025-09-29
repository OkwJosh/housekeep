import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:housekeep/utilities/colors.dart';

class AvailableJobsScreen extends StatelessWidget {
  const AvailableJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data — replace with real API later
    final availableJobs = [
      {
        'id': '1',
        'title': 'Deep House Cleaning',
        'location': 'Lekki, Lagos',
        'price': '\$75',
        'date': 'Sep 30, 2025',
        'time': '10:00 AM',
        'duration': '3 hours',
        'description': 'Full house cleaning including windows and kitchen.',
        'postedBy': 'Alice Cooper',
      },
      {
        'id': '2',
        'title': 'Garden Maintenance',
        'location': 'Ikeja, Lagos',
        'price': '\$50',
        'date': 'Oct 1, 2025',
        'time': '2:00 PM',
        'duration': '2 hours',
        'description': 'Mow lawn, trim hedges, remove weeds.',
        'postedBy': 'Bob Martin',
      },
      {
        'id': '3',
        'title': 'Pest Control Service',
        'location': 'Victoria Island',
        'price': '\$120',
        'date': 'Oct 3, 2025',
        'time': '9:00 AM',
        'duration': '4 hours',
        'description': 'Full home pest inspection and treatment.',
        'postedBy': 'Sarah Wilson',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Available Jobs',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Jobs List
          Expanded(
            child: availableJobs.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.work_off, size: 60, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          'No jobs available right now',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Check back later',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 13,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount: availableJobs.length,
                    itemBuilder: (context, index) {
                      final job = availableJobs[index];
                      return GestureDetector(
                        onTap: () {
                          // TODO: Navigate to job detail
                          Get.snackbar('Info', 'View job details');
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      job['title'] as String,
                                      style: GoogleFonts.spaceGrotesk(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    job['price'] as String,
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.green[700],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(Icons.location_on, size: 14, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Flexible(
                                    child: Text(
                                      job['location'] as String,
                                      style: GoogleFonts.spaceGrotesk(
                                        fontSize: 13,
                                        color: Colors.grey[600],
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.calendar_today, size: 12, color: Colors.grey[600]),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${job['date']} • ${job['time']} (${job['duration']})',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                job['description'] as String,
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 13,
                                  color: Colors.grey[700],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Text(
                                    'Posted by: ${job['postedBy']}',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const Spacer(),
                                  ElevatedButton(
                                    onPressed: () {
                                      // TODO: Apply for job
                                      Get.snackbar(
                                        'Success',
                                        'Applied to ${job['title']}!',
                                        backgroundColor: Colors.green,
                                        colorText: Colors.white,
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context).primaryColor,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      'Apply',
                                      style: GoogleFonts.spaceGrotesk(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}