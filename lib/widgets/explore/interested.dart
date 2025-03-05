import 'package:flutter/material.dart';

class Interested extends StatelessWidget {
  const Interested({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text('23 People Interested', style: TextStyle(color: const Color.fromARGB(255, 85, 85, 85),),),
        ),
        SizedBox(height: 2),
        InterestedPeople(),
        InterestedPeople(),
        InterestedPeople(),
        InterestedPeople(),
        InterestedPeople(),
        SizedBox(height: 80,)   
      ],
    );
  }
}


class InterestedPeople extends StatelessWidget {
  const InterestedPeople({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start, // Aligns avatar with text
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/profile-image.png'),
                ),
                const SizedBox(width: 14),
                Expanded( // ✅ Allows Column to expand fully
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'John Doe',
                        style: TextStyle(color: Color(0xFF3A6351), fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Interested 10/02/2025 11:55AM',
                        style: TextStyle(color: Color(0xFF3A6351), fontSize: 12),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'I would love to take these off your hands.',
                        style: TextStyle(color: Color.fromARGB(255, 85, 85, 85)),
                      ),

                      Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min, // Prevents stretching
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
                              color: Colors.grey,
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
        ),
        const SizedBox(height: 6),
      ],
    );
  }
}