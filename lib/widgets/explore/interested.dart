import 'package:flutter/material.dart';
import 'dart:math';

class Interested extends StatelessWidget {
  final List<InterestEntry> entries;

  const Interested({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    final List<InterestEntry> combinedEntries = [...generateMockInterests(5), ...entries];

    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0, bottom: 4.0),
            child: Text(
              '${combinedEntries.length} People Interested',
              style: const TextStyle(
                color: Color.fromARGB(255, 85, 85, 85),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        ...combinedEntries.map((entry) => InterestedPeople(entry: entry)).toList(),
        const SizedBox(height: 80),
      ],
    );
  }
}

class InterestedPeople extends StatelessWidget {
  final InterestEntry entry;

  const InterestedPeople({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage(entry.profileImage),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.name,
                    style: const TextStyle(
                      color: Color(0xFF3A6351),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Interested ${entry.timestamp}',
                    style: const TextStyle(
                      color: Color(0xFF3A6351),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    entry.message,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 85, 85, 85),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Decline',
                            style: TextStyle(color: Color(0xFFD60000)),
                          ),
                        ),
                        Container(
                          width: 1.5,
                          height: 20,
                          color: Colors.grey[300],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Accept',
                            style: TextStyle(color: Color(0xFF02AB0D)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InterestEntry {
  final String name;
  final String message;
  final String timestamp;
  final String profileImage;

  InterestEntry({
    required this.name,
    required this.message,
    required this.timestamp,
    required this.profileImage,
  });
}

List<InterestEntry> generateMockInterests(int count) {
  final names = ['Ava Smith', 'Liam Johnson', 'Olivia Brown', 'Noah Lee', 'Emma Davis'];
  final messages = [
    'I’d really appreciate this!',
    'Could I come pick it up tomorrow?',
    'This would be so helpful for me!',
    'Thank you for donating this.',
    'I love this item! Hope I get it.',
  ];
  final images = [
    'assets/images/avatar1.png',
    'assets/images/avatar2.png',
    'assets/images/avatar3.png',
    'assets/images/avatar4.png',
    'assets/images/avatar5.png',
  ];

  final random = Random();

  return List.generate(count, (index) {
    return InterestEntry(
      name: names[random.nextInt(names.length)],
      message: messages[random.nextInt(messages.length)],
      timestamp: generateRandomTime(),
      profileImage: images[random.nextInt(images.length)],
    );
  });
}

String generateRandomTime() {
  final now = DateTime.now();
  final random = Random();
  final minutesAgo = random.nextInt(720); // up to 12 hours ago
  final date = now.subtract(Duration(minutes: minutesAgo));

  final hour = date.hour == 0 ? 12 : (date.hour > 12 ? date.hour - 12 : date.hour);
  final minute = date.minute.toString().padLeft(2, '0');
  final ampm = date.hour >= 12 ? 'PM' : 'AM';

  return '${date.month}/${date.day}/${date.year} $hour:$minute $ampm';
}
