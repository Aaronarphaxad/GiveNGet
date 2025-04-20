import 'package:givenget/models/donation_item.dart';
import 'package:givenget/models/user.dart';
import 'package:givenget/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ItemsService {


  Future<List<DonationItem>> fetchDonationItems() async {
    final url = Uri.parse('http://192.168.1.126:8080/api/givenget/items');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        final items = jsonList.map((json) => DonationItem.fromJson(json)).toList();

        // ✅ Print each item to the console
        for (var item in items) {
          print('📦 Fetched item: ${item.title} - ${item.category} - ${item.imageUrl}');
        }

        return items;
      } else {
        print('❌ Failed to fetch items: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('🔥 Error fetching items: $e');
      return [];
    }
  }

  Future<bool> updateUserLikedItems({
    required String userId,
    required User currentUser,
    required DonationItem likedItem,
  }) async {
    final url = Uri.parse('http://192.168.1.126:8080/api/givenget/users/$userId');

    // Get the access token
    final accessToken = await AuthService().getAccessToken();
    if (accessToken == null) {
      print("❌ Failed to retrieve access token");
      return false;
    }

    // Add the liked item only if it's not already liked
    final alreadyLiked = currentUser.likedIDItems.any((item) => item.id == likedItem.id);
    final updatedLikedItems = alreadyLiked
        ? currentUser.likedIDItems
        : [...currentUser.likedIDItems, likedItem];

    // If using a manual constructor, create an updated user manually:
    final updatedUser = User(
      id: currentUser.id,
      name: currentUser.name,
      phoneNum: currentUser.phoneNum,
      email: currentUser.email,
      password: currentUser.password,
      location: currentUser.location,
      rating: currentUser.rating,
      likedIDItems: updatedLikedItems,
      donatedIDItems: currentUser.donatedIDItems,
      receivedIDItems: currentUser.receivedIDItems,
      notifications: currentUser.notifications,
      createdAt: currentUser.createdAt,
    );

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(updatedUser.toJson()),
    );

    if (response.statusCode == 200) {
      print("✅ User liked items updated successfully");
      return true;
    } else {
      print("❌ Failed to update user: ${response.statusCode} - ${response.body}");
      return false;
    }
  }

  Future<List<DonationItem>> fetchLikedItems(String userId) async {
    final url = Uri.parse('http://192.168.1.126:8080/api/givenget/users/$userId');

    try {
      final accessToken = await AuthService().getAccessToken();
      if (accessToken == null) {
        print("❌ Failed to retrieve access token");
        return [];
      }

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final user = User.fromJson(json);

        print("✅ Liked items fetched for user ${user.name}");
        return user.likedIDItems;
      } else {
        print("❌ Failed to fetch liked items: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print('🔥 Error fetching liked items: $e');
      return [];
    }
  }

  Future<List<DonationItem>> fetchUserDonations(String donorId) async {
    final url = Uri.parse('http://192.168.1.126:8080/api/givenget/items/donor/$donorId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => DonationItem.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch donations');
    }
  }

  Future<bool> deleteDonationItem(String itemId) async {
    final url = Uri.parse('http://192.168.1.126:8080/api/givenget/items/$itemId');
    final response = await http.delete(url);

    return response.statusCode == 200;
  }



}