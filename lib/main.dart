import 'package:city_break/page/CityActiviti.dart';
import 'package:city_break/page/trip.dart';
import 'package:flutter/material.dart';

void main()=>runApp(MaterialApp(
  theme: ThemeData(
    primaryColor: Colors.blue
  ),
  initialRoute: '/',
  routes: {
    '/':(context)=>const Trip(),
    '/city':(context)=>const Cityactiviti(),  
  },
)); 

