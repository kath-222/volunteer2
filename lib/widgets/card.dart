import 'package:flutter/material.dart';

class VolunteerCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  const VolunteerCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });

  @override
  State<VolunteerCard> createState() => _VolunteerCardState();
}

class _VolunteerCardState extends State<VolunteerCard> {
  bool isApplied = false;

  void toggleApply() {
    setState(() {
      isApplied = !isApplied;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      padding: const EdgeInsets.all(5),
      height: 200,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 225, 225, 225),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    widget.subtitle,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),

          Column(
            children: [
              SizedBox(
                width: 150,
                height: 140,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    widget.imagePath,
                    width: 150,
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton.icon(
                    onPressed: toggleApply,
                    icon: Icon(isApplied ? Icons.check : Icons.add),
                    label: Text(isApplied ? 'Applied' : 'Apply'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                      isApplied
                          ? Colors.green
                          : Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      //probably no need for row but im not going to mess it up now
    );
  }
}