import 'package:city_break/models/tripModels.dart';
import 'package:flutter/material.dart';
import 'package:city_break/mapping/mapping.dart';
class Trip extends StatefulWidget{
  const Trip ({
    super.key,
  });
  @override
  State<Trip> createState()=> _TrpState();
}

class _TrpState extends State<Trip>{
  List<Tripmodels>trip=[];
  @override
  void initState(){
    super.initState();
   loadTrips();
  }
Future<void> loadTrips() async {
  List<Tripmodels> trips = await getTrip();
  print(trips);
  await Future.delayed(Duration.zero); // Позволяет Flutter "вдохнуть"
  if (mounted) {
    setState(() {
      trip = trips;
    });
  }
}

        @override
        Widget build(BuildContext context){
          return Scaffold(
            appBar: AppBar(
              title: const Text('Поезки'),
              leading: Builder( 
            builder: (context)=> IconButton( icon: const Icon(Icons.menu),
              onPressed: (){
                Scaffold.of(context).openDrawer();
              },
              ),
              ),
              actions: [
                IconButton( icon: const Icon(Icons.search),
                onPressed: (){

                },
                )
              ],
              
            ),
                drawer: Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Text('Меню', style: TextStyle(color: Colors.white, fontSize: 24)),
                ),
                ListTile(
                  leading: Icon(Icons.trip_origin_sharp),
                  title: Text('Посещение'),
                     onTap: () {
                 Navigator.pushNamed(context, '/');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.location_city),
                  title: Text('Города'),
                  onTap: () {
                 Navigator.pushNamed(context, '/city');
                  },
                ),
              ],
            ),
          ),
    body: trip.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: trip.length,
            itemBuilder: (context, index) {
              final current = trip[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(current.city?.country ?? 'Страна не указана'),
                      Text(current.city?.name ?? 'Город не указан'),
                      Text('Оценка: ${current.rating}'),
                      Text('Заметки: ${current.personalNotes}'),
                    ],
                  ),
                ),
              );
            },
          ),

              floatingActionButton: FloatingActionButton(
            onPressed: () {
          
            },
            child: const Icon(Icons.add),
          ),
          );
    }
}