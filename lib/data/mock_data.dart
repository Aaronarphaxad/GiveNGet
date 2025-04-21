import '../models/donation_item.dart';

final List<DonationItem> mockFavouriteItems = [
  DonationItem(
    id: '1',
    title: 'Study Desk',
    description: 'Perfect desk for students',
    category: 'Books',
    imageUrl: 'assets/images/study-desk-3.jpg',
    donor: 'Reiben',
    location: 'Main Library',
    datePosted: '10-02-2025',
    availability: true,
    condition: 'New',
  ),
  DonationItem(
    id: '2',
    title: 'Piano',
    description: 'Perfect for music lovers',
    category: 'Furniture',
    imageUrl: 'assets/images/piano.jpg',
    donor: 'Yaolong',
    location: 'Community Hall',
    datePosted: '10-02-2025',
    availability: false,
    condition: 'Used',
  ),
];
