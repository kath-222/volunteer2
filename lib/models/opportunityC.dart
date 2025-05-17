class opportunityC {
  String description;
  String duration;
  String location;
  int numVolunteers;
  String requirements;
  String selectedField;
  String title;


  opportunityC(this.description,this.duration,this.location,this.numVolunteers,this.requirements,this.selectedField,this.title);

  Map<String, dynamic> toMap() {
    return{
      'description': description,
      'duration': duration,
      'location': location,
      'numVolunteers': numVolunteers,
      'requirements': requirements,
      'selectedField': selectedField,
      'title': title
    };
  }

  factory opportunityC.fromDoc(Map<String, dynamic> d){
    return opportunityC(
      d['description'] as String,
      d['duration'] as String,
      d['location'] as String,
      d['numVolunteers'] as int,
      d['requirements'] as String,
      d['selectedField'] as String,
      d['title'] as String,

    );
  }


}