import 'package:flutter/material.dart';

class NewsBanner extends StatelessWidget {
  const NewsBanner({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
  });
  final String title;
  final String description;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          Image.asset(
            imagePath,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              print("IMAGE LOAD ERROR: $error");
              return Text("Image failed to load");
            },
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: 70,
              padding: const EdgeInsets.all(12),
              color: const Color.fromARGB(110, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleLarge),
                  Text(
                    description,
                    style:
                    Theme.of(
                      context,
                    ).textTheme.titleMedium, // Color for subtext
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
