

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:volunteerfind/pages/data.dart';
import 'package:volunteerfind/pages/opportunity.dart';

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

      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(210, 100, 1, 1)),
              child: Text(
                'Volunteer Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const VolunteerProfilePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            ),
          ],
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

              Stack(
                children: [
                  // your existing banner
                  NewsBanner(
                    title: '100 Volunteers for Education!',
                    description: 'lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                    imagePath: 'assets/images/kidsbanner.png',
                  ),
                  // your logo in the corner
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 64,
                      height: 64,
                    ),
                  ),
                ],
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
              iconSize: 40,                     // controls the tappable area
              icon: Image.asset(
                'assets/images/logo.png',
                width: 32,
                height: 32,
              ),
              onPressed: () {
                // go to profile
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const opportunity(title: "Let Volunteer!")),
                );
              },
            ),

            IconButton(
              icon: Icon(Icons.dashboard_customize_rounded),
              onPressed: () {
                // go to login page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const data(title: "Oppertunities Data View")),
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
