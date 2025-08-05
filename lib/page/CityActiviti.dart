import 'package:city_break/mapping/mapping.dart';
import 'package:city_break/models/city.dart';
import 'package:flutter/material.dart';

class Cityactiviti extends StatefulWidget{
  const Cityactiviti({
      super.key,
  }); 
    @override
  State<Cityactiviti> createState()=> _Cityactiviti();
}

class _Cityactiviti extends State<Cityactiviti>{
  List<City>city=[];
void initState(){
    super.initState();
   loadCity();
  }
  Future<void> loadCity() async {
  List<City> citys = await getCity();
  
  await Future.delayed(Duration.zero); // Позволяет Flutter "вдохнуть"
  if (mounted) {
    setState(() {
      city = citys;
    });
  }
}
     
  @override
    Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(
          title: const Text('Города'),
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
          children:  [
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
body: city.isEmpty
    ? const Center(child: CircularProgressIndicator())
    : ListView.builder(
        itemCount: city.length,
        itemBuilder: (context, index) {
          final current = city[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(current.country),
                  Text(current.name),
                  Text(current.details),
                ],
              ),
            ),
          );
        },
      ),

          floatingActionButton: FloatingActionButton(
        onPressed: () {
       String country = '';
  String name = '';
  String details = '';

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        scrollable: true,
        title: Text('Добавить город'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Страна'),
              onChanged: (value) => country = value,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Город'),
              onChanged: (value) => name = value,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Описание'),
              onChanged: (value) => details = value,
              
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Закрыть диалог
            },
            child: Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () async{
              print('Добавлено: $country, $name, $details');
              await addCity(name, country, details);
              await loadCity();
              Navigator.of(context).pop(); // Закрыть диалог

              
            },
            child: Text('Сохранить'),
          ),
        ],
      );
    },
  );
        },
        child: const Icon(Icons.add),
      ),
      );
    }
} 