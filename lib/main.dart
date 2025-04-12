import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

class CityWeather {
  final String cityName;
  final List<int> temperatureToday;
  final List<String> startTimesToday;

  CityWeather({
    required this.cityName, 
    required this.temperatureToday,
    required this.startTimesToday
    });
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, CityWeather> weatherData = {};
  Future<void> fetchCityWeather(String cityKey, String gridUrl) async {
    final response = await http.get(Uri.parse(gridUrl));
    final Map<String, dynamic> data = jsonDecode(response.body);
    final List periods = data['properties']['periods'];

    final today = DateTime.now().toIso8601String().substring(0, 10);

    final todayPeriods = periods
        .where( (p)=> p['startTime'].startsWith(today) )
        .take(15) // hw many smapels we want to take
        .toList();

    final todayTemps = todayPeriods
        .map<int>((p)=> p['temperature'] as int)
        .toList();
        // .where((p) => p['startTime'].startsWith(today))
        // .take(10)
        // .map<int>((p) => p['temperature'] as int)
        // .toList();
    
    final startTimes = todayPeriods
        .map<String>((p) {
      final fullTime = DateTime.parse(p['startTime']);
      final hour = fullTime.hour;
      final formattedHour = hour % 12 == 0 ? 12 : hour % 12;
      final period = hour >= 12 ? 'PM' : 'AM';
      return '$formattedHour$period';
    })
    .toList();

    

    final cityWeather =
        CityWeather(
          cityName: cityKey, 
          temperatureToday: todayTemps,
          startTimesToday: startTimes
          );

    setState(() {
      weatherData[cityKey] = cityWeather;
    });
  }


  // List<Icon>     //rain icons
  List<String> daysOfWeek = ['Mon', 'Tues', 'Wes', 'Thr', 'Fri', 'Sat', 'Sun'];

  @override
  void initState() {
    super.initState();
    fetchCityWeather("miami",
        'https://api.weather.gov/gridpoints/MFL/50,50/forecast/hourly');
  }

  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
          children: <Widget>[
          // top main, curWeater ad city name
          Column(
            children: <Widget>[
            Text('MIAMI'),
            Text(
                'Currentyl it is : ${weatherData['miami']!.temperatureToday[3]} F in Miami'),
          ]),


          Expanded(child: 
          ListView(
            children: <Widget>[
              Text(
                //////////////////////////////////////
                'You have pushed the button this many times:',
              ),
              Text(
                ////////////////////////////////////
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),


              Text(
                  'The current time in Miami is ${DateTime.now().toIso8601String().substring(11, 16)}'),

              // forecast of today
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    for(int i=0; i<weatherData['miami']!.temperatureToday.length; i++)
                     Column(children: [
                      Text(' ${weatherData['miami']!.temperatureToday[i]} '),
                      Text('${weatherData['miami']!.startTimesToday[i]}'),
                     ],),
                    
                  ],
                ),
              ),

              // chance of rain
              Row(
                children: <Widget>[
                  for(int i=0; i<7; i++)
                    Text('  ${i}:00 PM')
                  
                  
                ],
              ),

              // example horizontal scroll
              SizedBox(
                height: 100,
                child: 
                ListView(
                // This next line does the trick.
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(width: 160, color: Colors.red),
                  Container(width: 70, color: Colors.blue),
                  Container(width: 160, color: Colors.green),
                  Container(width: 160, color: Colors.yellow),
                  Container(width: 160, color: Colors.orange),
                ],
              ),
              ),

              // temperature thrhought hte day
              Row(
                children: <Widget>[
                  for(int i=0; i<7; i++)
                    Text('  ${i}:00 AM')
                  
                  
                ],

              ),


              //Temparature for the week
              Row(
                children: <Widget>[
                  for(int i=0; i<7; i++)
                    Text(daysOfWeek[i])
                  
                  
                ],
          
              ),



              
              
            ],
          ),
          )
          


        ],
      )),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.

      // bottomNavigationBar: NavigationBar(destinations: <Widget>[

      //   NavigationDestination(icon: icon, label: label)
      // ]),
    );
  }
}
