import 'package:flutter/material.dart';
import 'package:givenget/models/donation_item.dart';
import 'package:givenget/screens/main_screens/explore/donation_detail_screen.dart';
import 'package:givenget/services/user_service.dart';

class FavouriteDonationGridListItem extends StatefulWidget {
  final List<DonationItem> favouriteItems;
  final int index;
  final Future<void> Function(BuildContext, DonationItem) removeFromFavourites;
  final VoidCallback? refreshFavourites;

  const FavouriteDonationGridListItem({
    super.key,
    required this.favouriteItems,
    required this.index,
    required this.removeFromFavourites,
    this.refreshFavourites,
  });

  @override
  State<FavouriteDonationGridListItem> createState() => _FavouriteDonationGridListItemState();
}

class _FavouriteDonationGridListItemState extends State<FavouriteDonationGridListItem> {
  String donorName = '...';

  @override
  void initState() {
    super.initState();
    fetchDonorName();
  }

  Future<void> fetchDonorName() async {
    final user = await UserService().fetchUserById(donorName);
    setState(() {
      donorName = user?.name ?? 'Unknown';
    });
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.favouriteItems[widget.index];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DonationDetailScreen(
              item: item,
              refreshFavorites: widget.refreshFavourites,
            ),
          ),
        );
      },
      child: Card(
        elevation: 3,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 156,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.network(
                        item.imageUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Donated by $donorName',
                          style: const TextStyle(fontSize: 12),
                        ),
                        Text(
                          'Posted ${item.datePosted}',
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: const Color.fromARGB(104, 0, 0, 0),
                    ),
                    child: IconButton(
                      onPressed: () async {
                        await widget.removeFromFavourites(context, item);
                        widget.refreshFavourites?.call();
                      },
                      icon: const Icon(Icons.clear, color: Colors.white, size: 14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
