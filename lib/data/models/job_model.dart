// lib/models/job.dart
class Job {
  final String id;
  final String seekerId;
  final String title;
  final String description;
  final String serviceType;
  final String location;
  final DateTime date;
  final String time;
  final String duration; // e.g., "3 hours"
  final String price;
  final JobStatus status;

  Job({
    required this.id,
    required this.seekerId,
    required this.title,
    required this.description,
    required this.serviceType,
    required this.location,
    required this.date,
    required this.time,
    required this.duration,
    required this.price,
    this.status = JobStatus.pending,
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json['id'] ?? '',
        seekerId: json['seekerId'] ?? '',
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        serviceType: json['serviceType'] ?? '',
        location: json['location'] ?? '',
        date: DateTime.parse(json['date'] ?? '2025-01-01'),
        time: json['time'] ?? '09:00 AM',
        duration: json['duration'] ?? '1 hour',
        price: json['price'] ?? '\$0',
        status: _getStatusFromString(json['status']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'seekerId': seekerId,
        'title': title,
        'description': description,
        'serviceType': serviceType,
        'location': location,
        'date': date.toIso8601String(),
        'time': time,
        'duration': duration,
        'price': price,
        'status': status.name,
      };

  static JobStatus _getStatusFromString(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return JobStatus.pending;
      case 'confirmed':
        return JobStatus.confirmed;
      case 'completed':
        return JobStatus.completed;
      case 'cancelled':
        return JobStatus.cancelled;
      default:
        return JobStatus.pending;
    }
  }
}

enum JobStatus { pending, confirmed, completed, cancelled }