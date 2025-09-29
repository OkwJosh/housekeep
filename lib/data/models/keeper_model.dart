import 'package:housekeep/data/models/user_model.dart';

class Keeper extends User {
  final String serviceType;
  final double rating;
  final int reviewCount;
  final String pricePerHour;
  final bool isAvailable;
  final List<String>? jobHistoryIds;

  Keeper({
    required super.id,
    required super.name,
    required super.email,
    super.phone,
    super.profileImage,
    required this.serviceType,
    required this.rating,
    required this.reviewCount,
    required this.pricePerHour,
    this.isAvailable = true,
    this.jobHistoryIds,
  });

  factory Keeper.fromJson(Map<String, dynamic> json) => Keeper(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        phone: json['phone'],
        profileImage: json['profileImage'],
        serviceType: json['serviceType'] ?? 'General',
        rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
        reviewCount: json['reviewCount'] ?? 0,
        pricePerHour: json['pricePerHour'] ?? '\$0/hr',
        isAvailable: json['isAvailable'] ?? true,
        jobHistoryIds: List<String>.from(json['jobHistoryIds'] ?? []),
      );

  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'serviceType': serviceType,
        'rating': rating,
        'reviewCount': reviewCount,
        'pricePerHour': pricePerHour,
        'isAvailable': isAvailable,
        'jobHistoryIds': jobHistoryIds,
      };
}