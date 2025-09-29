class Booking {
  final String id;
  final String jobId;
  final String keeperId;
  final DateTime createdAt;
  final BookingStatus status;

  Booking({
    required this.id,
    required this.jobId,
    required this.keeperId,
    required this.createdAt,
    this.status = BookingStatus.confirmed,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json['id'] ?? '',
        jobId: json['jobId'] ?? '',
        keeperId: json['keeperId'] ?? '',
        createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
        status: _getStatusFromString(json['status']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'jobId': jobId,
        'keeperId': keeperId,
        'createdAt': createdAt.toIso8601String(),
        'status': status.name,
      };

  static BookingStatus _getStatusFromString(String? status) {
    switch (status?.toLowerCase()) {
      case 'confirmed':
        return BookingStatus.confirmed;
      case 'in_progress':
        return BookingStatus.inProgress;
      case 'completed':
        return BookingStatus.completed;
      case 'cancelled':
        return BookingStatus.cancelled;
      default:
        return BookingStatus.confirmed;
    }
  }
}

enum BookingStatus { confirmed, inProgress, completed, cancelled }