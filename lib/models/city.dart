class City {
  final int id;
  final String name;
  final String country;
  final String details;

  City({required this.id, required this.name,required this.country,required this.details});
  factory City.fromJson(Map<String, dynamic>json){
    return City(
        id:json['id'],
        name:json['name'],
        country:json['country'],
        details:json['details'],
    );
  } 
  Map<String, dynamic> toJson(){
    return {
      'id':id,
      'name':name,
      'country':country,
      'details':details,
    };
  }
}