import 'package:flutter/material.dart';
import 'package:volunteerfind/pages/MyHomePage.dart';
import 'package:volunteerfind/pages/volunteerProfilePage.dart';

import 'data.dart';
import 'login.dart';
import 'orgProf.dart';

const Color mainThemeColor = Color(0xFF800000); // Maroon color

class opportunity extends StatefulWidget {
  const opportunity({super.key, required this.title});

  final String title;

  @override
  State<opportunity> createState() => _opportunityState();
}

class _opportunityState extends State<opportunity> {
  bool _showGrid = false;

  final List<Map<String, String>> volunteerCards = [
    {
      'title': 'Beach Cleanup',
      'subtitle': 'Help clean up the coastline',
      'imagePath': 'assets/images/beach.png',
      'description':
      'Join us in cleaning up our beautiful beaches and making a positive impact on the environment.',
      'requirements':
      'Must be 16+ years old, able to walk long distances, and have a passion for the environment.',
    },
    {
      'title': 'Blood Donation',
      'subtitle': 'Save lives by donating blood',
      'imagePath': 'assets/images/blood.png',
      'description':
      'Donate blood and save lives. A small act can make a big difference.',
      'requirements':
      'Must be 18+ years old, in good health, and weigh at least 50kg.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainThemeColor,
        title: Text('Lets Volunteer!'),
        centerTitle: true,
        actions: [

          IconButton(
            icon: Icon(_showGrid ? Icons.view_list : Icons.grid_view),
            onPressed: () => setState(() => _showGrid = !_showGrid),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: mainThemeColor),
              child: Text(
                'Volunteer Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                //Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage(title: "Home", username: "!!")),
                );
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
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              labelColor: Colors.white,
              indicatorColor: Colors.white,
              tabs: [
                Tab(icon: Icon(Icons.view_list), text: 'Opportunities'),
                Tab(icon: Icon(Icons.info), text: 'About'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _showGrid
                      ? GridView.count(
                    crossAxisCount: 2,
                    padding: const EdgeInsets.all(8),
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 3/4,
                    children: List.generate(volunteerCards.length, (i) {
                      final data = volunteerCards[i];
                      return Card(
                        color: Color.fromARGB(210, 100, 1, 1),
                        child: InkWell(
                          onTap: () => _openDetail(context, data),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Expanded(child: Image.asset(data['imagePath']!, fit: BoxFit.contain)),
                              const SizedBox(height: 8),
                              Text(data['title']!, style: const TextStyle(color:Colors.white,fontWeight: FontWeight.bold)),
                              Text(data['subtitle']!, style: const TextStyle(color: Colors.grey)),
                              const SizedBox(height: 8),

                            ],
                          ),
                        ),
                      );
                    }),
                  )
                      : ListView.builder(
                    itemCount: volunteerCards.length,
                    itemBuilder: (context, index) {
                      final cardData = volunteerCards[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => OpportunityPg(data: cardData),
                            ),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.all(10),
                          color: mainThemeColor.withOpacity(0.8),
                          child: ListTile(
                            leading: Image.asset(cardData['imagePath']!),
                            title: Text(
                              cardData['title']!,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              cardData['subtitle']!,
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Center(
                    child: Text(
                      'About Us: Learn more about our mission and vision.',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
                  MaterialPageRoute(builder: (context) => const MyHomePage(title: "Home", username: "....")),
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
      /*bottomNavigationBar: BottomAppBar(
        color: mainThemeColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.account_circle, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.logout, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            ),
          ],
        ),
      ),*/
    );
  }
}

class OpportunityPg extends StatelessWidget {
  final Map<String, String> data;

  const OpportunityPg({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(data['title']!)),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
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
              onTap: () {},
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(data['imagePath']!),
            const SizedBox(height: 16),
            Text(
              data['title']!,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(data['description']!, style: TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            Text(
              'Requirements:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(data['requirements']!, style: TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back to Opportunities'),
            ),
          ],
        ),
      ),
    );
  }
}


void _openDetail(BuildContext ctx, Map<String, String> data) {
  Navigator.push(
    ctx,
    MaterialPageRoute(builder: (_) => OpportunityPg(data: data)),
  );
}