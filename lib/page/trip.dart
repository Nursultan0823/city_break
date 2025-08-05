import 'package:city_break/models/tripModels.dart';
import 'package:city_break/models/city.dart';
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
   :ListView.builder(
  itemCount: trip.length,
  itemBuilder: (context, index) {
    final current = trip[index];

    return GestureDetector(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Выберите действие'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Вызов функции редактирования
                
                },
                child: Text('Изменить'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Вызов функции удаления
                  //_deleteTrip(current.id);
                },
                child: Text('Удалить'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Отмена'),
              ),
            ],
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(current.city?.country ?? 'Страна не указана'),
              Text(current.city?.name ?? 'Город не указан'),
              Text('Оценка: ${current.rating}'),
              Text('Заметки: ${current.personalNotes}'),
              Text('Дата Начало: ${current.startDate}'),
              Text('Дата Окончания: ${current.endDate}'),
            ],
          ),
        ),
      ),
    );
  },
),


              floatingActionButton: FloatingActionButton(
 onPressed: () async {
    List<City> cities = await getCity(); // Загружаем список городов
    City? selectedCity;
    String personalNotes = '';
    double rating = 0;
    DateTime startDate = DateTime.now();
    DateTime endDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setStateDialog) {
          return AlertDialog(
            title: Text('Добавить поездку'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<City>(
                    value: selectedCity,
                    hint: Text('Выберите город'),
                    isExpanded: true,
                    items: cities.map((city) {
                      return DropdownMenuItem(
                        value: city,
                        child: Text('${city.name}, ${city.country}'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setStateDialog(() {
                        selectedCity = value;
                      });
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Заметки'),
                    onChanged: (value) => personalNotes = value,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Оценка (0-10)'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => rating = double.tryParse(value) ?? 0,
                  ),
                  ListTile(
                    title: Text('Дата начала:n ${startDate.toLocal().toString().split(' ')[0]}'),
                    trailing: Icon(Icons.date_range),
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: startDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (date != null) {
                        setStateDialog(() {
                          startDate = date;
                        });
                      }
                    },
                  ),
                  ListTile(
                    title: Text('Дата окончания: ${endDate.toLocal().toString().split(' ')[0]}'),
                    trailing: Icon(Icons.date_range),
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: endDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (date != null) {
                        setStateDialog(() {
                          endDate = date;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Отмена'),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (selectedCity == null) return;
                  await addTrip(
                    cityId: selectedCity!.id,
                    personalNotes: personalNotes,
                    rating: rating,
                    startDate: startDate,
                    endDate: endDate,
                  );
                  await loadTrips(); // обновить список
                  Navigator.of(context).pop();
                },
                child: Text('Сохранить'),
              ),
            ],
          );
        });
      },
    );
  },
            child: const Icon(Icons.add),
          ),
          );
    }
}