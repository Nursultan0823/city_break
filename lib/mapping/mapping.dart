import 'package:city_break/models/city.dart';
import 'package:city_break/models/tripModels.dart';
import 'package:city_break/enum/enum.dart';
import 'package:dio/dio.dart';

Future<List<Tripmodels>> getTrip()async{
  final url= Url.getTrip.description;
  var dio = Dio();
  var response  = await dio.get(url);
  List<Tripmodels>trip =(response.data as List).map((json)=>Tripmodels.fromJson(json)).toList();
  return trip;
}
Future<List<City>> getCity()async{
  final url= Url.getCity.description;
  var dio = Dio();
  var response  = await dio.get(url);
  List<City>city =(response.data as List).map((json)=>City.fromJson(json)).toList();
  return city;
}
  Future<String> addCity(String name,String country,String details)async{
    var dio= Dio();
    var response = await dio.post(Url.addCity.description,data: {'name':name,'country':country,'details':details});
    return response.headers.toString();

  }
