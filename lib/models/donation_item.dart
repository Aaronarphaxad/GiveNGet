

class DonationItem {
  final String title;
  final String description;
  final String category;
  final String imageUrl;
  final String datePosted;
  final String donor;

  DonationItem( {
    required this.title,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.donor,
    required this.datePosted
  });
}