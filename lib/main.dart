import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

import 'dart:math';

import 'dart:ui';

import 'dart:convert';

import 'package:http/http.dart' as http;



import 'CustomWidgets_A.dart';




class CityWeather {
  final String cityName;

  final List<int> temperatureToday;
  final List<String> startTimesToday;
  
  final List<int> windSpeed;
  final List<String> windDirection;

  final List<int> precipChance;

  final List<String> weatherForecast;


  CityWeather({
    required this.cityName, 

    required this.temperatureToday,
    required this.startTimesToday,

    required this.windSpeed,
    required this.windDirection,

    required this.precipChance,

    required this.weatherForecast
    });


}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp(     {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gabe Weather App',
      theme: ThemeData(
        fontFamily: '.SF UI Text',     
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Loading'),
    );
    // return CupertinoApp(
    //   title: 'Flutter Demo',
    //   theme: CupertinoThemeData(

    //     textTheme: CupertinoTextThemeData(
    //       textStyle: const TextStyle(
    //         fontFamily: '.SF UI Text'
    //       ),
    //     ),

    //   ),
      
    //   home: const MyHomePage(title: 'Flutter Demo Home Page'),
    // );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // ----------- CITY TIMES !!!!!!!! -----------
    Map<String, String> localTimes = {};
    final List<String> cityCoords = [
      '25.7617,-80.1918',   // miami
      '29.7604,-95.3698',   // houston
      '34.0522,-118.2437',  // los angles  // bilbao
      '29.6516,-82.3248',   // gainesville
    ];
  
  Map<String, CityWeather> weatherData = {};
  Future<void> fetchCityWeather(String cityKey, String gridUrl, String coord) async {
    final response = await http.get(Uri.parse(gridUrl));
    final Map<String, dynamic> data = jsonDecode(response.body);
    final List periods = data['properties']['periods'];
    

    //final selectedPeriods = periods.take(24).toList(); // ← this gives you 24 hours starting from *now*
    final today = DateTime.now().toIso8601String().substring(0, 10);

    final parts = coord.split(',');

    final todayPeriods = periods
        .take(24).toList();
        //.where( (p)=> p['startTime'].startsWith(today) )
        //.take(7) // hw many smapels we want to take
        //.toList();

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

    final windSpeeds = todayPeriods
      .map<int>( (p) {
        
        final rawStringSpeeds = p['windSpeed'] as String; // "6 mph"
        final parts = rawStringSpeeds.split(' '); // "6" "mph"
        final intSpeeds = int.tryParse(parts.first) ?? 0;// 6
        return intSpeeds;
      }
      ).toList();

    // make second map of SE to degrees?
    final windDirection = todayPeriods
      .map<String>( (p) {

        final rawSpeeds = p['windDirection'] as String;
        return rawSpeeds;

      }).toList();




    final precipChances = todayPeriods
      .map<int>( (p) {

        final rawRain = p['probabilityOfPrecipitation']['value'];
        return rawRain;
      }).toList();

    
    final weatherForecasts = todayPeriods
      .map<String>( (p) {


        final rawForecast = p['shortForecast'];
        return rawForecast;
      }).toList();


    
    final ptsResp = await http.get(Uri.parse('https://api.weather.gov/points/$coord'));
    final stationsUrl = (jsonDecode(ptsResp.body)['properties']['observationStations']) as String;

    final stResp = await http.get(Uri.parse(stationsUrl));
    final stationId = (jsonDecode(stResp.body)['features'][0]['properties']['stationIdentifier']) as String;

    final obsResp = await http.get(
      Uri.parse('https://api.weather.gov/stations/$stationId/observations/latest')
    );
    final obsJson = jsonDecode(obsResp.body)['properties'] as Map<String,dynamic>;
    final timestamp = obsJson['timestamp'] as String; // e.g. "2025-04-25T20:10:00-04:00"


    // BACKGROUND COLORS !!!!!
    //
    //
    //  






    final dtUtc = DateTime.parse(timestamp);

    final dt = dtUtc.toLocal();

    final h  = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final ap = dt.hour >= 12 ? 'PM' : 'AM';
    final localStr = '$h:${dt.minute.toString().padLeft(2,'0')} $ap';


    final nowUtc = DateTime.now().toUtc();
    final hour = nowUtc.hour % 12 == 0 ? 12 : nowUtc.hour % 12;
    final ampm = nowUtc.hour >= 12 ? 'PM' : 'AM';
    final timeStr = '$hour:${nowUtc.minute.toString().padLeft(2,'0')} $ampm';


    final cityWeather =
        CityWeather(
          cityName: cityKey, 
          temperatureToday: todayTemps,
          startTimesToday: startTimes,
          windSpeed: windSpeeds,
          windDirection: windDirection,
          precipChance: precipChances,

          weatherForecast: weatherForecasts
          );

    setState(() {


      weatherData[cityKey] = cityWeather;
      localTimes[cityKey] = localStr;
    });
  }


  // List<Icon>     //rain icons
  List<String> daysOfWeek = ['Mon', 'Tues', 'Wes', 'Thr', 'Fri', 'Sat', 'Sun'];

  
  final List<String> cities = [
      'miami',
      'houston',
      'los angeles', // was Biblao
      'gainesville',
    ];

  final List<String> citiesAbreviation = [
      'MFL/50,50', // Miami
      'HGX/83,98', // Houston
      'LOX/154,34', // LosAngles   Bilbao (look up via /points lat/lon)
      'JAX/43,42', // Gainsville
    ];
  
    late double curTime;

    int _selectedIndex = 0;
    late String curCity;

    final List<RadialGradient> bgGradients = [  
      RadialGradient(
            //transform: GradientTransform.,
            center: Alignment(-0.99, -0.7),//Alignment.topCenter,
            radius: 1.2,
            colors: /* insert color here   */ [Color.fromARGB(255, 202, 217, 232), Color(0xFF4286f4)],//[Color(0xFF89CFF0), Color(0xFF4286f4)],
          
          ),
      RadialGradient(
            //transform: GradientTransform.,
            center: Alignment(-0.99, -0.7),//Alignment.topCenter,
            radius: 1.2,
            colors: /* insert color here   */ [Color.fromARGB(255, 0, 38, 77), Color.fromARGB(255, 83, 108, 148)],//[Color(0xFF89CFF0), Color(0xFF4286f4)],
          
          ),
    ];

    late int bgSelect;


  @override
  void initState() {

    bgSelect = 0;
    curCity = cities[0];
    super.initState();
    fetchCityWeather("miami",
        'https://api.weather.gov/gridpoints/MFL/50,50/forecast/hourly',
        cityCoords[0]);
  }

  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cw = weatherData[curCity];
    if (cw == null) {
      // Data for this city hasn’t loaded yet
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: const Center(child: CircularProgressIndicator()),
        bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: 
        (int idx) {
          setState(() {
            _selectedIndex = idx;
            curCity = cities[_selectedIndex];

            fetchCityWeather("${curCity}",
                            'https://api.weather.gov/gridpoints/${citiesAbreviation[idx]}/forecast/hourly',
                            cityCoords[idx],
                            );     
          });
        },
        destinations: [
          for (var city in cities)
            NavigationDestination(
              icon: const Icon(Icons.location_city),
              label: city[0].toUpperCase() + city.substring(1),
            ),
        ],
      ),

      );
    }

    int minTemp = cw.temperatureToday.reduce(min);
    int maxTemp = cw.temperatureToday.reduce(max);

    return Scaffold(
      // appBar: AppBar(
      //   // TRY THIS: Try changing the color here to a specific color (to
      //   // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
      //   // change color while the other colors stay the same.
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
      // ),
      body:

      // _selectedIndex == 0
      //   // Miami UI
      // ? 
      
    Stack(

        children: <Widget>[

          Container(
        decoration: BoxDecoration(
          gradient: bgGradients[bgSelect],
        ),
      ),



        
      
      Center(
          
          child: Column(
          children: <Widget>[
          
          Column(

            children: <Widget>[

              Padding(padding: EdgeInsets.fromLTRB(0, 100, 0, 0)),

           

            RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                color: const Color.fromARGB(255, 238, 238, 238),
                shadows: [Shadow(
                          color: Colors.black12,
                          offset: Offset(3.0, 4.0),
                          blurRadius: 9.0,

                ) ]
              ),
              children: [
                TextSpan(
                  text: 'MY LOCATION\n',
                  style: TextStyle(
                    fontSize: 16.5,
                    height: 0.8,       //  line height (0.8× fontSize = 4.4px gap)
                  ),
                ),
                TextSpan(
                  text: '${curCity.toUpperCase()}\n',
                  style: TextStyle(
                    fontSize: 41,
                    height: 1.27,
                    shadows: [
                      BoxShadow(blurRadius: 10.9, offset: Offset(0.1, 0.2),color: const Color.fromARGB(198, 0, 0, 0)).scale(2),
                    ]       //  1.0× fontSize = no extra gap
                  ),
                ),
                TextSpan(
                  text: '${weatherData[curCity]!.temperatureToday[3]}°\n',
                  style: TextStyle(
                    fontSize: 120,
                    height: 1.0,
                    shadows: [Shadow( color: Colors.black12, offset: Offset(3.0, 4.0), blurRadius: 3.9)]
                  ),
                ),
                TextSpan( //   -------------------------------- TODO --------------- get API  call for  Sunny or Cloudy
                  text: '${ /* Sunny */ weatherData[curCity]!.weatherForecast[0]  }\n',//'${weatherData[curCity]!.temperatureToday[3]}°',
                  style: TextStyle(
                    fontSize: 21.3,
                    height: 1.1,
                    shadows: [
                      BoxShadow(blurRadius: 10.9, offset: Offset(0.1, 0.2),color: const Color.fromARGB(255, 0, 0, 0)).scale(2),
                    ]
                    
                  ),
                ),
                // TextSpan(           //   -------------------------------- TODO --------------- inser higheest and lowest temp of the day
                //   text: 'H:${ '87'  }',//'${weatherData[curCity]!.temperatureToday[3]}°',
                //   style: TextStyle(
                //     fontSize: 22,
                //     height: 1.19,
                //   ),
                // ),
                // TextSpan(           //   -------------------------------- TODO --------------- inser higheest and lowest temp of the day
                //   text: '°',//'${weatherData[curCity]!.temperatureToday[3]}°',
                //   style: TextStyle(
                //     fontSize: 50,
                //     height: 1.19,
                //   ),
                // ),
                // TextSpan(           //   -------------------------------- TODO --------------- inser higheest and lowest temp of the day
                //   text: ' L:${  '63' }',//'${weatherData[curCity]!.temperatureToday[3]}°',
                //   style: TextStyle(
                //     fontSize: 22,
                //     height: 1.19,
                //   ),
                // ),
                // TextSpan(           //   -------------------------------- TODO --------------- inser higheest and lowest temp of the day
                //   text: '°\n',//'${weatherData[curCity]!.temperatureToday[3]}°',
                //   style: TextStyle(
                //     fontSize: 32,
                //     height: -10.0,
                //   ),
                // ),


                TextSpan(           //   -------------------------------- TODO --------------- inser higheest and lowest temp of the day
                  text: 'H:${ minTemp }°  L:${  maxTemp }°\n',//'${weatherData[curCity]!.temperatureToday[3]}°',
                  style: TextStyle(
                    fontSize: 22,
                    height: 1.19,
                    shadows: [
                      BoxShadow(blurRadius: 10.9, offset: Offset(0.1, 0.2),color: const Color.fromARGB(255, 0, 0, 0)).scale(2),
                    ]
                  ),
                ),

            

              ],
            ),
          ),

          



            // Padding(
            //   padding: EdgeInsets.fromLTRB(0, 90, 0, 0),
            //   child: Text( 'My Location'.toUpperCase(),
            //   style: TextStyle(fontSize: 15.5)),
            // ),

            // Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            //   child: Text(curCity ,
            //       style: TextStyle( fontSize: 41),
            //     ),
            //   ),

            // Padding(
            //   padding: EdgeInsets.fromLTRB(31, 0, 0, 0),
            //   child: Text('${weatherData[curCity]!.temperatureToday[3]}°',
            //   style: TextStyle(
            //               fontSize: 115,
            //               fontWeight: FontWeight.w100,
            //               ),),
              
            // ),
            
            
            // Text(curCity),
            // Text(
            //     'Currentyl it is : ${weatherData[curCity]!.temperatureToday[3]} F in ${cities[_selectedIndex]}'
            //     ),
            // Text(
            //   'Local time in ${curCity[0].toUpperCase()+curCity.substring(1)}: '
            //   '${localTimes[curCity] ?? '...'}'
            //   ),
          ]),


          Expanded(child: 
          ListView(
            children: <Widget>[
              // Text(
              //   //////////////////////////////////////
              //   '____________',
              // ),
              // Text(
              //   ////////////////////////////////////
              //   '$_counter',
              //   style: Theme.of(context).textTheme.headlineMedium,
              // ),


              

              
 // forecast of today
              // ------------------------------------------ BOXOUBLE 1 ---------------------------------------
              //-----------------------------------------------------------------------------------------------
              //------------------------------------------------------------------------------------------------
              // Center(child: Text(' TEMPS OF THE DAY BOXULEEEEEE'),),
              

                
              Padding(padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: 
              

                    ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: 
                    
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: 
                  


                  Container(
                    width:  double.infinity,
                    height: 255,//--------------------------------------------  DE HEIGHT !!!!
                    padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
                    color: Color.fromARGB(255, 66, 75, 109).withOpacity(0.25),


                    child :  Column(
                    mainAxisSize:  MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                    Text('Temperatures today',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 255, 255, 255),               // full opacity
                          fontSize: 16,
                          height: 1.3
                      ),
                    ),
                    

                    // inser thwit divider line 
                    Divider(
                        color: const Color.fromARGB(133, 211, 207, 207),
                        thickness: 0.7,
                        height: 29,  // space around
                      ),


                    Container(
                      height: 190,//-----------------     that annoying exxtra highet at the bottom
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          for(int i=0; i<weatherData[ curCity ]!.temperatureToday.length; i++)
                          Column(children: [
                            Padding(padding: EdgeInsets.fromLTRB(3.7, 0.2, 3.7, 0 ), child: 
                              Boxule(weatherData[curCity]!.temperatureToday ,weatherData[curCity]!.temperatureToday[i] ,  '${weatherData[curCity]!.startTimesToday[i]}'),
                            )
                            
                            // Text('${weatherData[curCity]!.temperatureToday[i]}'),

                            // Text('${weatherData[curCity]!.startTimesToday[i]}'),
                          ],),
                          
                        ],
                      ),
                    )


                  ],),

                  ),
                  ),
                ),
              ),






             // rain of the day
              // ------------------------------------------ BOXOUBLE 3 ---------------------------------------
              //-----------------------------------------------------------------------------------------------
              //--------------------------------------------------------------------------------------
              Padding(padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: 
              

                    ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: 
                    
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: 
                  


                  Container(
                    width:  double.infinity,
                    height: 255,//--------------------------------------------  DE HEIGHT !!!!
                    padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
                    color: Color.fromARGB(255, 66, 75, 109).withOpacity(0.25),


                    child :  Column(
                    mainAxisSize:  MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                    Text('Rain today',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 255, 255, 255),               // full opacity
                          fontSize: 16,
                          height: 1.3
                      ),
                    ),
                    

                    // inser thwit divider line 
                    Divider(
                        color: const Color.fromARGB(133, 211, 207, 207),
                        thickness: 0.7,
                        height: 29,  // space around
                      ),


                    Container(
                      height: 190,//-----------------     that annoying exxtra highet at the bottom
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          for(int i=0; i<weatherData[ curCity ]!.temperatureToday.length; i+=1)
                          Column(children: [
                            Padding(padding: EdgeInsets.fromLTRB(6, 0.2, 6, 0 ), child: 
                              Boxule3(weatherData[curCity]!.precipChance ,weatherData[curCity]!.precipChance[i] , '${weatherData[curCity]!.startTimesToday[i]}', ),
                            )
                            
                            // Text('${weatherData[curCity]!.temperatureToday[i]}'),

                            // Text('${weatherData[curCity]!.startTimesToday[i]}'),
                          ],),
                          
                        ],
                      ),
                    )


                  ],),

                  ),
                  ),
                ),
              ),


              
















  

               
                

                
              




              // wind of the day
              // ------------------------------------------ BOXOUBLE 2 ---------------------------------------
              //-----------------------------------------------------------------------------------------------
              //--------------------------------------------------------------------------------------
              Padding(padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: 
              

                    ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: 
                    
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: 
                  


                  Container(
                    width:  double.infinity,
                    height: 255,//--------------------------------------------  DE HEIGHT !!!!
                    padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
                    color: Color.fromARGB(255, 66, 75, 109).withOpacity(0.25),


                    child :  Column(
                    mainAxisSize:  MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                    Text('Wind today',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 255, 255, 255),               // full opacity
                          fontSize: 16,
                          height: 1.3
                      ),
                    ),
                    

                    // inser thwit divider line 
                    Divider(
                        color: const Color.fromARGB(133, 211, 207, 207),
                        thickness: 0.7,
                        height: 29,  // space around
                      ),


                    Container(
                      height: 190,//-----------------     that annoying exxtra highet at the bottom
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          for(int i=0; i<weatherData[ curCity ]!.temperatureToday.length; i+=2)
                          Column(children: [
                            Padding(padding: EdgeInsets.fromLTRB(6, 0.2, 6, 0 ), child: 
                              Boxule2(weatherData[curCity]!.windSpeed ,weatherData[curCity]!.windSpeed[i] , '${weatherData[curCity]!.startTimesToday[i]}', weatherData[curCity]!.windDirection[i]),
                            )
                            
                            // Text('${weatherData[curCity]!.temperatureToday[i]}'),

                            // Text('${weatherData[curCity]!.startTimesToday[i]}'),
                          ],),
                          
                        ],
                      ),
                    )


                  ],),

                  ),
                  ),
                ),
              ),


              







              
              
              
              
              
              
              
              
              
              // Center(child: Text(' WINDS OF THE DAY '),),
              // Padding(padding: EdgeInsets.fromLTRB(50, 10, 50, 50),
              //   child: 
                
              //   Stack(alignment: AlignmentDirectional.center,
              //   children: <Widget>[
                
              //   Container(
              //         width: double.infinity ,
              //         height: 202,
              //         color: const Color.fromARGB(255, 102, 215, 209),
              //   ),
                
              //   Container(
              //     height: 250,
              //     child: ListView(
              //       scrollDirection: Axis.horizontal,

              //       children: <Widget>[
              //         for(int i=0; i<weatherData[curCity]!.windSpeed.length; i++)
              //           Column(children: [
              //             Padding(padding: EdgeInsets.fromLTRB(20, 0.2, 3, 20 ), 
              //             child:
              //               Boxule2(weatherData[curCity]!.windSpeed ,weatherData[curCity]!.windSpeed[i] , '${weatherData[curCity]!.startTimesToday[i]}')
              //               //Text('${weatherData[curCity]!.windSpeed[i]}'),
              //               // insert boxule2
              //             ),
              //             Text('${weatherData[curCity]!.windDirection[i] }'),
              //             Text('${weatherData[curCity]!.startTimesToday[i]}'),
              //           ],)


              //       ],
                
              //     ),
              //   ),
                

              //   ],),
                
                
                
                
                
              // ),





             



































              // // temperature thrhought hte day
              // Row(
              //   children: <Widget>[
              //     for(int i=0; i<7; i++)
              //       Text('  ${i}:00 AM')
                  
                  
              //   ],

              // ),


              // //Temparature for the week
              // Row(
              //   children: <Widget>[
              //     for(int i=0; i<7; i++)
              //       Text(daysOfWeek[i])
                  
                  
              //   ],
          
              // ),



              
              
            ],
          
          
          
          ),
          ),
          
          // FloatingActionButton(
          //   onPressed: _incrementCounter,
          //   tooltip: 'Increment',
          //   child: const Icon(Icons.add),
          // ), // This trailing comma makes auto-formatting nicer for build methods.
      Padding(padding: EdgeInsets.all(9),
        child: 
          ElevatedButton(
                  child: const Text('Chande Mode'),
                  onPressed: () async {
                    final result = await Navigator.push<DayNight>(
                      context,
                      MaterialPageRoute(builder: (context)=> const BackGroundOptionsPage()),
                    );
                    if (result != null){
                      setState(() {
                        bgSelect = (result == DayNight.day) ? 0 : 1;
                      });
                    }
                    // Navigate to second route when tapped.
                    
                  },
                ),
        
          )

        ],
      )),
      ],
      ),
    

    //   : Center(
    //   child: Text(
    //     cities[_selectedIndex].toUpperCase(),
    //     style: const TextStyle(fontSize: 32),
    //   ),
    // ),


      // bottomNavigationBar: NavigationBar(
      //   destinations: <Widget>[

      //   NavigationDestination(icon: icon, label: label)
      // ]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: 
        (int idx) {
          setState(() {
            _selectedIndex = idx;
            curCity = cities[_selectedIndex];

            fetchCityWeather("${curCity}",
                            'https://api.weather.gov/gridpoints/${citiesAbreviation[idx]}/forecast/hourly',
                            cityCoords[idx],
                            );     
          });
        },
        destinations: [
          for (var city in cities)
            NavigationDestination(
              icon: const Icon(Icons.location_city),
              label: city[0].toUpperCase() + city.substring(1),
            ),
        ],
      ),


    );
  }
}




enum DayNight { day, night }

class BackGroundOptionsPage extends StatefulWidget {
  const BackGroundOptionsPage({super.key});

  @override
  State<BackGroundOptionsPage> createState() => _BackGroundOptionsPageState();
}

class _BackGroundOptionsPageState extends State<BackGroundOptionsPage> {

  DayNight _selection = DayNight.day;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Route')),
      body: 
      
      Center(

        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            
                RadioListTile<DayNight>(
                    title: Text('Day'),
                    value: DayNight.day,
                    groupValue: _selection,
                    onChanged: ( p ) {
                      setState(()=> {
                        _selection = p!
                      });
                    },
                  ),
           
                 RadioListTile<DayNight>(
                    title: Text('Night'),
                    value: DayNight.night,
                    groupValue: _selection,
                    onChanged: (p) {
                      setState(() => {
                      _selection = p!
                      });
                    },
                
                ),
            
            

            ElevatedButton(
              child: Text('Apply'),
              onPressed: () {
                // Navigate back to first route when tapped.

                Navigator.pop(context, _selection);
              },
              
            ),

     
      




          ],
        ),
        
      ),
      
    );
  }
}