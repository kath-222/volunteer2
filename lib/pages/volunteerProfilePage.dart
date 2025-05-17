import 'package:flutter/material.dart';

class VolunteerProfilePage extends StatefulWidget {
  const VolunteerProfilePage({super.key});

  @override
  State<VolunteerProfilePage> createState() => _VolunteerProfilePageState();
}

class _VolunteerProfilePageState extends State<VolunteerProfilePage> {
  bool isEditing = false;

  final TextEditingController firstNameController = TextEditingController(text: "Liya");
  final TextEditingController lastNameController = TextEditingController(text: "Alazri");
  final TextEditingController usernameController = TextEditingController(text: "@layaazri");
  final TextEditingController phoneController = TextEditingController(text: "95333120");
  DateTime birthDate = DateTime(2003, 7, 9); // default value
  String gender = "Female";

  void _pickDate() async {
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: birthDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (newDate != null) {
      setState(() {
        birthDate = newDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top profile header
              Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                color: Colors.red[800],
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/avatar.png'),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${firstNameController.text} ${lastNameController.text}",
                          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              isEditing = !isEditing;
                            });
                          },
                        ),
                      ],
                    ),
                    const Text("Computer Science", style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    buildEditableRow(firstNameController, lastNameController),
                    const SizedBox(height: 10),
                    buildEditableField(usernameController),
                    buildEditableField(phoneController),

                    // Birthdate Picker
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: isEditing
                            ? GestureDetector(
                          onTap: _pickDate,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${birthDate.day}/${birthDate.month}/${birthDate.year}"),
                              const Icon(Icons.calendar_today, size: 16),
                            ],
                          ),
                        )
                            : Text("${birthDate.day}th ${_monthName(birthDate.month)} ${birthDate.year}"),
                      ),
                    ),

                    // Gender Radio Buttons
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: isEditing
                            ? Row(
                          children: [
                            Expanded(
                              child: RadioListTile(
                                value: "Male",
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value.toString();
                                  });
                                },
                                title: const Text("Male"),
                              ),
                            ),
                            Expanded(
                              child: RadioListTile(
                                value: "Female",
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value.toString();
                                  });
                                },
                                title: const Text("Female"),
                              ),
                            ),
                          ],
                        )
                            : Text(gender),
                      ),
                    ),

                    const SizedBox(height: 20),

                    if (isEditing)
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isEditing = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Profile updated.")),
                          );
                        },
                        child: const Text("Save Changes"),
                      ),
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text("LOCATION", style: TextStyle(color: Colors.grey)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                          image: AssetImage("assets/images/map_placeholder.png"), // Your local asset
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: const Center(
                        child: Icon(Icons.location_pin, size: 40, color: Colors.red),
                      ),
                    ),
                    const SizedBox(height: 30),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  Widget buildEditableRow(TextEditingController first, TextEditingController last) {
    return Row(
      children: [
        Expanded(child: buildField(first)),
        const SizedBox(width: 10),
        Expanded(child: buildField(last)),
      ],
    );
  }

  Widget buildEditableField(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: buildField(controller),
    );
  }

  Widget buildField(TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: isEditing
          ? TextField(
        controller: controller,
        decoration: const InputDecoration(border: InputBorder.none),
      )
          : Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(controller.text, style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return months[month - 1];
  }
}
