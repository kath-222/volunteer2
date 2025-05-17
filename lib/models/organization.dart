class organization {
  String licenseNumber;
  String orgName;
  String username;
  String password;


  organization(this.licenseNumber,this.orgName,this.username,this.password);

  Map<String, dynamic> toMap() {
    return{
      'licenseNumber': licenseNumber,
      'orgName': orgName,
      'password': password,
      'username': username,
    };
  }

  factory organization.fromDoc(Map<String, dynamic> d){
    return organization(
      d['licenseNumber'] as String,
      d['orgName'] as String,
      d['username'] as String,
      d['password'] as String,

    );
  }


}