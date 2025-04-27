


import 'package:flutter/material.dart';

import '../widgets/card.dart';
import '../widgets/newsBanner.dart';
import 'login.dart';
import '../theme/theme_const.dart';
import 'opportunityPage.dart';
import 'orgProf.dart';
import 'postOpp.dart';
import 'postOpportunityPage.dart';
import 'volunteerProfilePage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required String this.username});



  final String title;
  final String username;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late String welcomeMessage;

  final List<Map<String, String>> volunteerCards = [
    {
      'title': 'Beach Cleanup',
      'subtitle': 'Help clean up the coastline',
      'imagePath': 'assets/images/beach.png',
    },
    {
      'title': 'Blood Donation',
      'subtitle': 'Save lives by donating blood',
      'imagePath': 'assets/images/blood.png',
    },
    {
      'title': 'Beach Cleanup',
      'subtitle': 'Help clean up the coastline',
      'imagePath': 'assets/images/beach.png',
    },
    {
      'title': 'Blood Donation',
      'subtitle': 'Save lives by donating blood',
      'imagePath': 'assets/images/blood.png',
    },
    {
      'title': 'Beach Cleanup',
      'subtitle': 'Help clean up the coastline',
      'imagePath': 'assets/images/beach.png',
    },
  ];
  @override
  void initState() {
    super.initState();
    welcomeMessage = 'Welcome ${widget.username}!';
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Lets Volunteer!'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OpportunityPage()),
              );
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.account_circle),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const VolunteerProfilePage()),
            );
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                welcomeMessage,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              // banner
              NewsBanner(
                title: '100 Volunteers for Education!',
                description:
                'lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                imagePath: 'assets/images/kidsbanner.png',
              ),
              const SizedBox(height: 10),

              // List of volunteer cards
              ListView.builder(
                shrinkWrap:
                true, // To ensure it doesn't take full screen height
                physics:
                NeverScrollableScrollPhysics(), // Disable scrolling in ListView
                itemCount: volunteerCards.length,
                itemBuilder: (context, index) {
                  final cardData = volunteerCards[index];
                  return VolunteerCard(
                    title: cardData['title']!,
                    subtitle: cardData['subtitle']!,
                    imagePath: cardData['imagePath']!,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Postopp()),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 153, 0, 0), // Your dark red color
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                // Handle home button press
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Postopp()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                // go to profile
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OrgProfile()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                // go to login page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            ),


          ],
        ),
      ),
    );
  }
}
