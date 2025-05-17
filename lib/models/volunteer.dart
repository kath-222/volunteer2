class Volunteer {
  String fname;
  String lname;

  //int age;
  //String gender;
  String username;
  String password;

  //String location;
  //String qualifications;
  //String profilePicture;
  Volunteer(this.fname,this.lname,this.username,this.password);

  Map<String, dynamic> toMap() {
    return{
      'fname': fname,
      'lname': lname,
      'password': password,
      'username': username,
    };
  }

  factory Volunteer.fromDoc(Map<String, dynamic> d){
    return Volunteer(
        d['fname'] as String,
        d['lname'] as String,
        d['username'] as String,
        d['password'] as String,

    );
  }



  /*
  Volunteer({
    required this.name,
    required this.age,
    required this.gender,
    required this.username,
    this.location = '',
    this.qualifications = '',
    this.profilePicture = '',
  });*/
}