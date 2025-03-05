import 'package:flutter/material.dart';

class ChangeLanguage extends StatelessWidget {
  ChangeLanguage({super.key});

  final List<Map<String, dynamic>> languages = [
    {
      "languageID": 0,
      "language": "Auto",
    },
    {
      "languageID": 1,
      "language": "English",
    },
    {
      "languageID": 2,
      "language": "Français",
    },
    {
      "languageID": 3,
      "language": "Русский",
    },
    {
      "languageID": 4,
      "language": "简体中文",
    },
    {
      "languageID": 5,
      "language": "繁體中文",
    },
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Language'),),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: languages.map((item) {
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.cyan[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 30,
                  child: Icon(Icons.language, size: 30),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    "${item["language"]}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          );
        }).toList(),

      ),

    );
  }
}
