class Volunteer {
  String name;
  int age;
  String gender;
  String username;
  String location;
  String qualifications;
  String profilePicture;

  Volunteer({
    required this.name,
    required this.age,
    required this.gender,
    required this.username,
    this.location = '',
    this.qualifications = '',
    this.profilePicture = '',
  });
}