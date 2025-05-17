import 'package:flutter/material.dart';


class PostOpportunityPage extends StatefulWidget {
  const PostOpportunityPage({super.key});

  @override
  State<PostOpportunityPage> createState() => _PostOpportunityPageState();
}

class _PostOpportunityPageState extends State<PostOpportunityPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController volunteersNeededController = TextEditingController();
  final TextEditingController requirementsController = TextEditingController();

  final List<String> fields = [
    "Education",
    "Environment",
    "Health",
    "Community",
  ];

  String selectedField = "Education";

  List<Map<String, dynamic>> postedOpportunities = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[800], // Red background like the image
        automaticallyImplyLeading: false, // Remove default back button
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Cancel button
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cancel button action (go back)
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
            // Title
            const Text(
              'Post opportunity',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Post button
            TextButton(
              onPressed: _postOpportunity,
              child: const Text(
                'Post',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 400,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Icon(
                    Icons.add_a_photo,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            const SizedBox(height: 20),
            buildTextField(titleController, 'Opportunity Title'),

            const SizedBox(height: 10),
            buildTextField(durationController, 'Duration'),

            const SizedBox(height: 10),
            buildTextField(locationController, 'Location'),

            const SizedBox(height: 10),
            buildTextField(volunteersNeededController, 'Number of Volunteers Needed', keyboardType: TextInputType.number),

            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedField,
              items: fields.map((field) {
                return DropdownMenuItem<String>(
                  value: field,
                  child: Text(field),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedField = value!;
                });
              },
              decoration: const InputDecoration(
                hintText: "Field",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),

            const SizedBox(height: 10),
            buildTextField(descriptionController, 'Description', maxLines: 3),

            const SizedBox(height: 10),
            buildTextField(requirementsController, 'Requirements (Optional)', maxLines: 2),
            const SizedBox(height: 10),


            const SizedBox(
                height: 20
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: _postOpportunity,
                  child: const Text('Post Opportunity')
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget buildTextField(
      TextEditingController controller,
      String hint, {
        int maxLines = 1,
        TextInputType keyboardType = TextInputType.text,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  void _postOpportunity() {
    if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    print('Opportunity posted:');
    print('Title: ${titleController.text}');
    print('Description: ${descriptionController.text}');
    print('Location: ${locationController.text}');
    print('Duration: ${durationController.text}');
    print('Field: $selectedField');
    print('Volunteers Needed: ${volunteersNeededController.text}');
    print('Requirements: ${requirementsController.text}');

    postedOpportunities.add({
      'title': titleController.text,
      'description': descriptionController.text,
      'location': locationController.text,
      'duration': durationController.text,
      'field': selectedField,
      'volunteersNeeded': volunteersNeededController.text,
      'requirements': requirementsController.text,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opportunity Posted Successfully!')),
    );

    _clearForm();
  }

  void _clearForm() {
    titleController.clear();
    descriptionController.clear();
    locationController.clear();
    durationController.clear();
    volunteersNeededController.clear();
    requirementsController.clear();

    setState(() {
      selectedField = "Education"; // reset dropdown
    });
  }

}
