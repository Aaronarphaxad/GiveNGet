import 'package:givenget/models/donation_item.dart';

class User {
  final String id;
  final String name;
  final String phoneNum;
  final String email;
  final String password;
  final String location;
  final int rating;
  final List<DonationItem> likedIDItems;
  final List<DonationItem> donatedIDItems;
  final List<DonationItem> receivedIDItems;
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
    required this.likedIDItems,
    required this.donatedIDItems,
    required this.receivedIDItems,
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
      rating: json['rating'] is int ? json['rating'] : int.tryParse(json['rating']?.toString() ?? '0') ?? 0,
      likedIDItems: List<DonationItem>.from(json['likedIDItems'] ?? []),
      donatedIDItems: List<DonationItem>.from(json['likedIDItems'] ?? []),
      receivedIDItems: List<DonationItem>.from(json['likedIDItems'] ?? []),
      notifications: List<String>.from(json['notifications'] ?? []),
      createdAt: DateTime.tryParse(json['createdAt']?.toString() ?? '') ?? DateTime.now(),
    );
  }


  // factory User.fromJson(Map<String, dynamic> json) {
  //   return User(
  //     id: json['id'] ?? '',
  //     name: json['name'] ?? '',
  //     phoneNum: json['phoneNum'] ?? '',
  //     email: json['email'] ?? '',
  //     password: json['password'] ?? '',
  //     location: json['location'] ?? '',
  //     rating: json['rating'] ?? 0,
  //     likedIDItems: (json['likedIDItems'] as List<dynamic>?)
  //             ?.map((item) => DonationItem.fromJson(item))
  //             .toList() ??
  //         [],
  //     donatedIDItems: (json['donatedIDItems'] as List<dynamic>?)
  //             ?.map((item) => DonationItem.fromJson(item))
  //             .toList() ??
  //         [],
  //     receivedIDItems: (json['receivedIDItems'] as List<dynamic>?)
  //             ?.map((item) => DonationItem.fromJson(item))
  //             .toList() ??
  //         [],
  //     notifications: List<String>.from(json['notifications'] ?? []),
  //     createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
  //   );
  // }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNum': phoneNum,
      'email': email,
      'password': password,
      'location': location,
      'rating': rating,
      'likedIDItems': likedIDItems.map((item) => item.id).toList(),
      'donatedIDItems': donatedIDItems.map((item) => item.id).toList(),
      'receivedIDItems': receivedIDItems.map((item) => item.id).toList(),
      'notifications': notifications,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}