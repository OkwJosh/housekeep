

import 'package:housekeep/data/models/user_model.dart';

class Seeker extends User {
  final List<String>? savedKeeperIds;
  final List<String>? savedAddresses;

  Seeker({
    required super.id,
    required super.name,
    required super.email,
    super.phone,
    super.profileImage,
    this.savedKeeperIds,
    this.savedAddresses,
  });

  factory Seeker.fromJson(Map<String, dynamic> json) => Seeker(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        phone: json['phone'],
        profileImage: json['profileImage'],
        savedKeeperIds: List<String>.from(json['savedKeeperIds'] ?? []),
        savedAddresses: List<String>.from(json['savedAddresses'] ?? []),
      );

  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'savedKeeperIds': savedKeeperIds,
        'savedAddresses': savedAddresses,
      };
}