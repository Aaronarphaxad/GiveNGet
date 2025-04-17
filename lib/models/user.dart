import 'package:givenget/models/donation_item.dart';

class User {
  final String id;
  final String name;
  final String phoneNum;
  final String email;
  final String password;
  final String location;
  final int rating;
  final List<DonationItem> likedItems;
  final List<DonationItem> donatedItems;
  final List<DonationItem> receivedItems;
  final List<String> notifications;
  final DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.phoneNum,
    required this.email,
    required this.password,
    required this.location,
    required this.rating,
    required this.likedItems,
    required this.donatedItems,
    required this.receivedItems,
    required this.notifications,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      phoneNum: json['phoneNum'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      location: json['location'] ?? '',
      rating: json['rating'] ?? 0,
      likedItems: (json['likedItems'] as List<dynamic>?)
              ?.map((item) => DonationItem.fromJson(item))
              .toList() ??
          [],
      donatedItems: (json['donatedItems'] as List<dynamic>?)
              ?.map((item) => DonationItem.fromJson(item))
              .toList() ??
          [],
      receivedItems: (json['receivedItems'] as List<dynamic>?)
              ?.map((item) => DonationItem.fromJson(item))
              .toList() ??
          [],
      notifications: List<String>.from(json['notifications'] ?? []),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNum': phoneNum,
      'email': email,
      'password': password,
      'location': location,
      'rating': rating,
      'likedItems': likedItems.map((item) => item.toJson()).toList(),
      'donatedItems': donatedItems.map((item) => item.toJson()).toList(),
      'receivedItems': receivedItems.map((item) => item.toJson()).toList(),
      'notifications': notifications,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}