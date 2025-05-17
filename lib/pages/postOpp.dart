
import 'package:flutter/material.dart';
import 'package:volunteerfind/models/opportunityC.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Postopp extends StatefulWidget {
  const Postopp({super.key});

  @override
  State<Postopp> createState() => _PostoppState();
}

class _PostoppState extends State<Postopp> {
  final _formKey = GlobalKey<FormState>();

  // Form fields
  String? title, duration, location, description, requirements;
  int? numVolunteers;
  String? selectedField;

  final List<String> fields = [
    'Education',
    'Healthcare',
    'Environment',
    'Community Service'
  ];

  void _submitForm()  async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      //Make new Organization
      final newVol = opportunityC(
          description!,
          duration!,
          location!,
          numVolunteers!,
          requirements!,
          selectedField!,
          title!,
      );

      // Write Volunteer into collection
      await FirebaseFirestore.instance
          .collection('Opportunity')
          .add(newVol.toMap());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Opportunity posted successfully!')),
      );
    } else{
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Fali post')),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 153, 0, 0),
        leading: TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel', style: TextStyle(color: Colors.white)),
        ),
        title: const Text('Post an opportunity', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _submitForm,
            child: const Text('Post', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Empty image container (no upload)
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade300,
                  ),
                  child: const Icon(Icons.image, size: 50, color: Colors.grey),
                ),

                const SizedBox(height: 16),

                // Form fields
                _buildTextField('Opportunity\'s title', (value) => title = value),
                const SizedBox(height: 12),
                _buildTextField('Duration', (value) => duration = value),
                const SizedBox(height: 12),
                _buildTextField('Location', (value) => location = value),
                const SizedBox(height: 12),
                _buildTextField('Required number of volunteers', (value) {
                  numVolunteers = int.tryParse(value ?? '');
                }, keyboardType: TextInputType.number),
                const SizedBox(height: 12),

                // Dropdown
                DropdownButtonFormField<String>(
                  decoration: _inputDecoration('Field'),
                  items: fields
                      .map((field) => DropdownMenuItem(value: field, child: Text(field)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedField = value;
                    });
                  },
                  validator: (value) => value == null ? 'Please select a field' : null,
                ),

                const SizedBox(height: 12),
                _buildTextField('Description (Optional)', (value) => description = value, maxLines: 3),
                const SizedBox(height: 12),
                _buildTextField('Volunteer requirements (Optional)', (value) => requirements = value, maxLines: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildTextField(String label, Function(String?) onSaved,
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return TextFormField(
      decoration: _inputDecoration(label),
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: (value) {
        if (value == null || value.isEmpty) {
          if (label.contains('Optional')) {
            return null;
          }
          return 'Please fill in $label';
        }
        return null;
      },
      onSaved: onSaved,
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      filled: true,
      fillColor: Colors.white,
    );
  }
}


