import 'package:flutter/material.dart';
import 'package:volunteerfind/pages/MyHomePage.dart';
import 'package:volunteerfind/pages/opportunity.dart';
import 'package:volunteerfind/pages/volunteerProfilePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volunteerfind/models/opportunityC.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';
import 'orgProf.dart';

const Color mainThemeColor = Color(0xFF800000); // Maroon color

class data extends StatefulWidget {
  const data({super.key, required this.title});

  final String title;

  @override
  State<data> createState() => _dataState();
}

class _dataState extends State<data> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainThemeColor,
        title: Text('Opportunities Data Control'),
        centerTitle: true,
        actions: [

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
        length: 3,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'Read'),
                Tab(text: 'Update'),
                Tab(text: 'Delete'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildReadTab(),
                  _buildUpdateTab(),
                  _buildDeleteTab(),
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


  String _search = '';

  Widget _buildReadTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            decoration: const InputDecoration(
              labelText: 'Search by title',
              prefixIcon: Icon(Icons.search),
              hintText: 'Type a title fragment…',
            ),
            onChanged: (v) => setState(() => _search = v.trim()),
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: (_search.isEmpty
                ? FirebaseFirestore.instance.collection('Opportunity')
                : FirebaseFirestore.instance
                .collection('Opportunity')
                .where('title', isGreaterThanOrEqualTo: _search)
                .where('title', isLessThanOrEqualTo: '$_search\uf8ff')
            )
                .orderBy('title')
                .snapshots(),
            builder: (ctx, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final docs = snap.data!.docs;
              if (docs.isEmpty) {
                return const Center(child: Text('No matching titles.'));
              }
              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (ctx, i) {
                  final data = docs[i].data()! as Map<String, dynamic>;
                  final opp  = opportunityC.fromDoc(data);
                  return ListTile(
                    title: Text(opp.title),
                    subtitle: Text('${opp.location} • ${opp.selectedField}'),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }



  Widget _buildUpdateTab() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Opportunity').snapshots(),
      builder: (ctx, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        return ListView(
          children: snap.data!.docs.map((doc) {
            final data = doc.data()! as Map<String, dynamic>;
            final opp  = opportunityC.fromDoc(data);

            return ListTile(
              title: Text(opp.title),
              trailing: IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () => _showEditDialog(doc),
              ),
            );
          }).toList(),
        );
      },
    );
  }

// dialog to edit and save changes
  Future<void> _showEditDialog(QueryDocumentSnapshot doc) async {
    final data = doc.data()! as Map<String, dynamic>;
    final opp  = opportunityC.fromDoc(data);

    // prefill controllers
    final titleCtrl        = TextEditingController(text: opp.title);
    final descCtrl         = TextEditingController(text: opp.description);
    final durationCtrl     = TextEditingController(text: opp.duration);
    final locationCtrl     = TextEditingController(text: opp.location);
    final volunteersCtrl   = TextEditingController(text: opp.numVolunteers.toString());
    final requirementsCtrl = TextEditingController(text: opp.requirements);
    final fieldCtrl        = TextEditingController(text: opp.selectedField);

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Opportunity'),
        content: SingleChildScrollView(
          child: Column(children: [
            TextField(controller: titleCtrl,        decoration: InputDecoration(labelText: 'Title')),
            TextField(controller: descCtrl,         decoration: InputDecoration(labelText: 'Description')),
            TextField(controller: durationCtrl,     decoration: InputDecoration(labelText: 'Duration')),
            TextField(controller: locationCtrl,     decoration: InputDecoration(labelText: 'Location')),
            TextField(controller: volunteersCtrl,   decoration: InputDecoration(labelText: 'Number of Volunteers'), keyboardType: TextInputType.number),
            TextField(controller: requirementsCtrl, decoration: InputDecoration(labelText: 'Requirements')),
            TextField(controller: fieldCtrl,        decoration: InputDecoration(labelText: 'Field')),
          ]),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await doc.reference.update({
                'title'         : titleCtrl.text,
                'description'   : descCtrl.text,
                'duration'      : durationCtrl.text,
                'location'      : locationCtrl.text,
                'numVolunteers' : int.parse(volunteersCtrl.text),
                'requirements'  : requirementsCtrl.text,
                'selectedField' : fieldCtrl.text,
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Updated successfully!'))
              );
            },
            child: const Text('Save'),
          ),
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ],
      ),
    );
  }


  Widget _buildDeleteTab() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Opportunity').snapshots(),
      builder: (ctx, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        return ListView(
          children: snap.data!.docs.map((doc) {
            final opp = opportunityC.fromDoc(doc.data()! as Map<String, dynamic>);
            return ListTile(
              title: Text(opp.title),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Delete Opportunity'),
                      content: Text('Are you sure you want to delete "${opp.title}"?'),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                        TextButton(onPressed: () => Navigator.pop(context, true),  child: const Text('Delete')),
                      ],
                    ),
                  );
                  if (confirm == true) {
                    await doc.reference.delete();
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Deleted successfully!'))
                    );
                  }
                },
              ),
            );
          }).toList(),
        );
      },
    );
  }



}


