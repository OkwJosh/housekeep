import 'package:cloud_firestore/cloud_firestore.dart';

class Job {
  final String id;
  final String seekerId;
  final String title;
  final String description;
  final String location;
  final DateTime date;
  final String time;
  final String duration;
  final String price;
  final String status; // 'open', 'confirmed', etc.
  final List<String> applicants;

  Job({
    required this.id,
    required this.seekerId,
    required this.title,
    required this.description,
    required this.location,
    required this.date,
    required this.time,
    required this.duration,
    required this.price,
    required this.status,
    this.applicants = const [],
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json['id'] ?? '',
        seekerId: json['seekerId'] ?? '',
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        location: json['location'] ?? '',
        date: (json['date'] as Timestamp).toDate(),
        time: json['time'] ?? '09:00 AM',
        duration: json['duration'] ?? '1 hour',
        price: json['price'] ?? '\$0',
        status: json['status'] ?? 'open',
        applicants: List<String>.from(json['applicants'] ?? []),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'seekerId': seekerId,
        'title': title,
        'description': description,
        'location': location,
        'date': date,
        'time': time,
        'duration': duration,
        'price': price,
        'status': status,
        'applicants': applicants,
      };
}