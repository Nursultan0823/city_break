import 'package:city_break/models/city.dart';

class Tripmodels {
 final int id;
 final City? city;
 final String startDate;
 final String endDate;
 final int rating;
 final String personalNotes;
 Tripmodels({required this.id,required this.city,
 required this.startDate,required this.endDate,required this.personalNotes,required this.rating});
  factory Tripmodels.fromJson(Map<String,dynamic>json){
    return Tripmodels(
      id:json['id'],
   city: json['city'] != null
        ? City.fromJson(json['city'])
        : null,
      startDate:json['startDate'],
      endDate:json['endDate'],
      rating:json['rating'],
      personalNotes: json['personalNotes']
    );
  }
  Map<String,dynamic>toJson(){
    return  {
      'id':id,
      'citymodels': city?.toJson(),
      'startDate':startDate,
      'endDate':endDate,
      'rating':rating,
      'personalNotes':personalNotes,
    };
  }
  @override
String toString() {
  return 'Tripmodels(id: $id, city: ${city?.name}, country: ${city?.country}, '
         'startDate: $startDate, endDate: $endDate, rating: $rating, notes: $personalNotes)';
}
}