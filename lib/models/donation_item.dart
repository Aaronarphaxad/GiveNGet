

class DonationItem {
  final String title;
  final String description;
  final String category;
  final String imageUrl;
  final String datePosted;
  final String donor;
  final String condition;
  final bool availability;

  DonationItem( {
    required this.title,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.donor,
    required this.datePosted,
    required this.availability,
    required this.condition
  });
}