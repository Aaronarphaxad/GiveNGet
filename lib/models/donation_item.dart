class DonationItem {
  final String id;
  final String title;
  final String description;
  final String category;
  final String imageUrl;
  final String donor;
  final String location;
  final String datePosted;
  final bool availability;
  final String condition;

  DonationItem({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.donor,
    required this.location,
    required this.datePosted,
    required this.availability,
    required this.condition,
  });

  factory DonationItem.fromJson(Map<String, dynamic> json) {
    return DonationItem(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      imageUrl: (json['imageUrls'] as List?)?.first ?? '', // get first image
      donor: json['donorId'] ?? '',
      location: json['location'] ?? '',
      datePosted: json['datePosted'] ?? '',
      availability: json['availability'] ?? false,
      condition: json['condition'] ?? '',
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'imageUrls': [imageUrl], // convert back to list for server
      'donorId': donor,
      'location': location,
      'datePosted': datePosted,
      'availability': availability,
      'condition': condition,
    };
  }
}