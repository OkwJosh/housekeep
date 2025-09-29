// lib/models/user.dart
class User {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? profileImage;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        phone: json['phone'],
        profileImage: json['profileImage'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'profileImage': profileImage,
      };
}