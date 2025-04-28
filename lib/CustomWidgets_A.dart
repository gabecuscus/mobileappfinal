import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';
import 'dart:math' as math;

class Boxule extends StatefulWidget {
  final List<int> temps;
  final int temp;
  final String time;
  
  
  const Boxule(this.temps, this.temp, this.time, {super.key});

  @override
  State<Boxule> createState() => _BoxuleState();
}

class _BoxuleState extends State<Boxule> {

  @override

  Widget build(BuildContext context) {
  
  // declare variables heer

  // thermometer logic lerp stuff

  // find the maximum and minum vlaue

  int tempMin = widget.temps.reduce(min);
  int tempMax = widget.temps.reduce(max);

  int range = tempMax - tempMin;
  int adjustedVal = widget.temp - tempMin;
  double tempVis = adjustedVal / range;// from 0 to 1
  double tempVisual = 30.0 * tempVis + 50.0;


    return 
    
    SizedBox(
      // round corners,
      // dteermine length and margin
      //

      child: 
    
    Column(

      children: <Widget>[


    


      Center(


      child: Padding(
        //  USE STACK !!!!!!!!!! ?????????
        padding: EdgeInsets.fromLTRB(0.0, 1.0, 0.0, 0.0),
        child: Column(
          children: <Widget>[


            // TIME ---------- --------------------
            //      ---------- --------------------
            //      ---------- --------------------
            Row( children: [
              Text(
                widget.time.substring(0, widget.time.length - 2),
                style: TextStyle(
                  color: Colors.white ,

                ),
              ),
              Text(
                widget.time.substring(widget.time.length - 2, widget.time.length), 
                style: TextStyle(
                  fontSize: 7.0,
                  color: Colors.white,
                  ),
              )
                  ],
            ),






            // TEMP VISUAL -----
            //      ---------- --------------------
            //      ---------- --------------------

          // ClipRRect(
          //   borderRadius:  BorderRadius.circular(18),
          //   child: 

          // ),





            Stack(
              alignment: Alignment.center,
              children: <Widget>[

          
              

                Container(
                  width: 30,
                  height: 102,
                  decoration: BoxDecoration(
                    // color: Colors.transparent,

                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 255, 255, 255).withOpacity(0.55), 
                        Colors.transparent,
                              ],
                      begin: Alignment.bottomCenter,
                      end:Alignment.topCenter 
                      ),
                          
                    border: Border.all(
                      
                      color:Color.fromARGB(255, 255, 255, 255).withOpacity(0.25),
                      width: 2, ),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(20.0, 13.0),
                      top: Radius.circular(35)) ,
                    boxShadow: [
                      BoxShadow(
                        color:Color.fromARGB(255, 66, 75, 109).withOpacity(0.25),
                        offset: Offset(3,3),
                        blurRadius: 2.0,
                        

                      ),
                    ]
                    
                  ),

                ),

               

                
                

                // Container(
                //   width: 70,
                //   height: 72,
                //   color: const Color.fromARGB(255, 239, 228, 227),
                // ),
              Positioned(
                bottom: 0,
                left: 10,
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.elliptical(25, 25)),
                    child: Container(
                      width: 10,
                      height: tempVisual,//50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors:[ 
                            Color.fromARGB(255, 66, 75, 109).withOpacity(0.05),
                            Color.fromARGB(255, 198, 4, 78).withOpacity(0.5),
                            Color.fromARGB(255, 198, 4, 78).withOpacity(1.0),
                          ]
                      ),
                    ),
                      
                      // child: ,// white ball

                  ),
                  ),

                  
                  
                  
                  ),
              // Positioned(
              //   bottom: 0,
              //   left: 20,
              //     child:  Container(
              //       width: 30,
              //       height: tempVisual,//50,
              //       color: const Color.fromARGB(255, 198, 4, 78),
              //     ),
                  
                  
              //     ),
              

                
              ],
            ),


            // Stack(
            //   alignment: AlignmentDirectional.bottomCenter,
            //   children: <Widget>[
            //     Container(
            //       width: 80,
            //       height: 102,
            //       color: const Color.fromARGB(255, 7, 7, 2),
            //     ),
            //     Container(
            //       width: 20,
            //       height: 100,
            //       color: const Color.fromARGB(255, 239, 228, 227),
            //     ),
            //     Container(
            //       width: 10,
            //       height: tempVisual,//50,
            //       color: const Color.fromARGB(255, 198, 4, 78),
            //     ),
            //   ],
            // ),




            // TEMP NUMBER
            //      ---------- --------------------
            //      ---------- --------------------
            Row(children : <Widget>[
                Text(
                  '${widget.temp}',
                  style: TextStyle(
                    color: Colors.white,
                    shadows: [
                      BoxShadow(blurRadius: 2.3, offset: Offset(0.1, 0.2),color: const Color.fromARGB(107, 0, 0, 0)).scale(1.5),
                    ],
                  ),

              ),
              Text(
                '°',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white, 
                  shadows: [
                    BoxShadow(blurRadius: 2.3, offset: Offset(0.1, 0.2),color: const Color.fromARGB(107, 0, 0, 0)).scale(1.5),
                  ],
                ),
              )
            ]),
            
            
            

          ],
        ),




      ),
    )
    
    
    
    
    ])
    )
    
    
    ;












  }
}


























// boxule 2
class Boxule2 extends StatefulWidget {
  
  final List<int> windSpeeds;
  final int wind;
  final String time;
  final String windDirection;
  
  const Boxule2(this.windSpeeds, this.wind, this.time, this.windDirection, {super.key});

  @override
  State<Boxule2> createState() => _boxule2State();
}

class _boxule2State extends State<Boxule2> {
       

  @override

  Widget build(BuildContext context) {
  
  // declare variables heer

  // thermometer logic lerp stuff

  // find the maximum and minum vlaue

  int windMin = widget.windSpeeds.reduce(min);
  int windMax = widget.windSpeeds.reduce(max);

  int range = windMax - windMin;
  int adjustedVal = widget.wind - windMin;
  double windVis = adjustedVal / range;// from 0 to 1
  double windVisual = 30.0 * windVis + 50.0; ////////// --- IMPORTATN !!!!! animation values go here to make mvoement



  final Map<String, double> windDirMap = {
    'N':   0.0,
    'NE':  45.0,
    'E':   90.0,
    'SE':  135.0,
    'S':   180.0,
    'SW':  225.0,
    'W':   270.0,
    'NW':  315.0
      };

  
  double windDirVisDeg = windDirMap[widget.windDirection] ?? 0.0;
  double windDirVis = windDirVisDeg * ( math.pi / 180.0);



    return Center(


      child: Padding(
        //  USE STACK !!!!!!!!!! ?????????
        padding: EdgeInsets.fromLTRB(3.0, 1.0, 3.0, 1.0),
        child: Column(
          children: <Widget>[
            // TIME ----------
            Row( children: [
              Text(
                widget.time.substring(0, widget.time.length - 2),
                style: TextStyle(
                  fontSize: 15.0,
                  color: const Color.fromARGB(240, 255, 255, 255),
                ),
              ),
              Text(
                widget.time.substring(widget.time.length - 2, widget.time.length), 
                style: TextStyle(
                  fontSize: 9.0,
                  color: const Color.fromARGB(226, 255, 255, 255),
                   ),
              )
                  ],
            ),

            // wind VISUAL -----
            Stack(
              alignment: Alignment.center,
              children: <Widget>[

                Container(
                  width: 77,
                  height: 97,
                  decoration: BoxDecoration(
                    // color: Colors.transparent,

                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 255, 255, 255).withOpacity(0.55), 
                        Colors.transparent,
                              ],
                      begin: Alignment.bottomCenter,
                      end:Alignment.topCenter 
                      ),
                          
                    border: Border.all(
                      
                      color:Color.fromARGB(255, 255, 255, 255).withOpacity(0.25),
                      width: 2, ),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(20.0, 13.0),
                      top: Radius.circular(35)) ,
                    boxShadow: [
                      BoxShadow(
                        color:Color.fromARGB(255, 66, 75, 109).withOpacity(0.25),
                        offset: Offset(3,3),
                        blurRadius: 2.0,
                        

                      ),
                    ]
                    
                  ),

                ),

               

              Positioned(

                bottom: 30,
                left: 30,
                
                
                  
                  child:
                  Transform.rotate(
                    angle: windDirVis,/* inser direction value here */     // ------------------------------------------
                    child:

                  Column(children: [

                    // for(int i=0; i<3; i++) // -------------------------- COME BACK TO THSI FOR LOOOPP TO MAKE COPIES OF MULTIPLE WIND GUSTS !!!!!
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.elliptical(25, 25)),
                      child: Container(
                        width: 20.0*windVis,
                        height: 50.0*windVis,//windVisual,//50,  /* inser magnitude value here */,     // --------------------------------
                        
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors:[ 
                              Color.fromARGB(255, 138, 163, 177).withOpacity(0.00),
                              Color.fromARGB(255, 4, 52, 198).withOpacity(0.5),
                              Color.fromARGB(255, 4, 94, 198).withOpacity(1.0),
                            ]
                        ),
                      ),
                        
                        // child: ,// white ball

                    ),
                    ),


                  ],),  
                  
                  
                  ),


                  ),
          

                
              ],
            ),


            

            // TEMP NUMBER
            Row(children : <Widget>[

              RichText(

                text: 
              

              TextSpan(children: [

                  TextSpan(
                    text: '${widget.wind}',
                    style: TextStyle(
                      color: Color.fromARGB(221, 255, 255, 255),
                      shadows: [
                          BoxShadow(blurRadius: 2.3, offset: Offset(0.1, 0.2),color: const Color.fromARGB(255, 0, 0, 0)).scale(1.5)
                      ],
                    ),
                ),

                TextSpan(
                    text: ' mph  ',
                    style: TextStyle(
                      color: Color.fromARGB(221, 255, 255, 255),
                    ),
                ),


              ]),
              ),


              Text(
                '${widget.windDirection}',
                style: TextStyle(
                  fontSize: 20.0,
                  color: const Color.fromARGB(221, 255, 255, 255),
                  shadows: [
                    // Shadow(blurRadius: 0.01, offset: Offset(5, 5),color: Colors.black12),
                    BoxShadow(blurRadius: 3.9, offset: Offset(0.1, 0.2),color: const Color.fromARGB(255, 0, 0, 0)).scale(2),
                    
                  ],
                  ),
              )
            ]),
            
            
            

          ],
        ),




      ),
    );












  }
}

































class Boxule3 extends StatefulWidget {
 
 
  final List<int> rainChances;
  final int rain;
  final String time;
  
  const Boxule3(this.rainChances, this.rain, this.time, {super.key});

  @override
  State<Boxule3> createState() => _Boxule3State();
}

class _Boxule3State extends State<Boxule3> {
  @override
  Widget build(BuildContext context) {

  int rainMin = widget.rainChances.reduce(min);
  int rainMax = widget.rainChances.reduce(max);

  int range = rainMax - rainMin;
  int adjustedVal = widget.rain - rainMin;
  double rainVis = adjustedVal / range;// from 0 to 1
  double rainVisual = 30.0 * rainVis + 50.0; ////////// --- IMPORTATN !!!!! animation values go here to make mvoement

  double anyRain = rainVis == 0.0 ? 0.0 : 1.0;

  Color sunShine = rainVis == 0.0 ? Colors.amberAccent : Colors.transparent;


  final Map<String, double> rainDirMap = {
    'N':   0.0,
    'NE':  45.0,
    'E':   90.0,
    'SE':  135.0,
    'S':   180.0,
    'SW':  225.0,
    'W':   270.0,
    'NW':  315.0
      };
  // double rainDirVis = rainDirMap[widget.rainDirection] ?? 0.0;







        return Center(


      child: Padding(
        //  USE STACK !!!!!!!!!! ?????????
        padding: EdgeInsets.fromLTRB(3.0, 1.0, 3.0, 1.0),
        child: Column(
          children: <Widget>[
            // TIME ----------
            Row( children: [
              Text(
                widget.time.substring(0, widget.time.length - 2),
                style: TextStyle(
                  fontSize: 15.0,
                  color: const Color.fromARGB(240, 255, 255, 255),
                ),
              ),
              Text(
                widget.time.substring(widget.time.length - 2, widget.time.length), 
                style: TextStyle(
                  fontSize: 9.0,
                  color: const Color.fromARGB(226, 255, 255, 255),
                   ),
              )
                  ],
            ),

            // wind VISUAL -----
            Stack(
              alignment: Alignment.center,
              children: <Widget>[

                Container(
                  width: 77,
                  height: 97,
                  decoration: BoxDecoration(
                    // color: Colors.transparent,

                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 255, 255, 255).withOpacity(0.55),
                        sunShine, // sunchine color
                              ],
                      begin: Alignment.bottomCenter,
                      end:Alignment.topCenter 
                      ),
                          
                    border: Border.all(
                      
                      color:Color.fromARGB(255, 255, 255, 255).withOpacity(0.25),
                      width: 2, ),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.elliptical(20.0, 13.0),
                      bottom: Radius.circular(35)) ,
                    boxShadow: [
                      BoxShadow(
                        color:Color.fromARGB(255, 66, 75, 109).withOpacity(0.25),
                        offset: Offset(3,3),
                        blurRadius: 2.0,
                        

                      ),
                    ]
                    
                  ),

                ),

               

              Positioned(

                // alignment: Alignment.topCenter,
                top:10,
              
                
                
                  
                  child:
                    
                  
                  Row(children: [
                    
                    for(int i=0; i<3; i++) 
                      Padding(padding: EdgeInsets.fromLTRB(0.1, 0, 0.1, 0),
                      child:

                          ClipRRect(
                            borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(3, 3)),
                            // padding:
                            child: Container(
                              width: 20.0,//*rainVis + 5.0,
                              height: 30.5*rainVis + 10.0*(anyRain) + (anyRain)*10.0*(  Random().nextDouble() ),//windVisual,//50,  /* inser magnitude value here */,     // --------------------------------
                              
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  end: Alignment.bottomCenter,
                                  begin: Alignment.topCenter,
                                  colors:[ 
                                    // Color.fromARGB(255, 138, 163, 177).withOpacity(0.00),
                                    // Color.fromARGB(255, 4, 52, 198).withOpacity(0.1),
                                    // Color.fromARGB(255, 4, 52, 198).withOpacity(0.2),
                                    // Color.fromARGB(255, 4, 52, 198).withOpacity(0.5),
                                    // Color.fromARGB(255, 4, 94, 198).withOpacity(1.0),
                                    Color.fromARGB(255, 215, 229, 246).withOpacity(0.0),
                                    Color(0xFF4A90E2).withOpacity(0.8),  // strong blue at top
                                  ]
                              ),
                              // boxShadow: [
                              //   BoxShadow(blurRadius: 0.1, offset: Offset(0.1, 8.0), color: const Color.fromARGB(255, 255, 255, 255)).scale(3),
                              // ]
                            ),
                              
                              // child: ,// white ball

                          ),
                          ),

                      
                      ),


                  ],)
                  
                  


                  ),
          

                
              ],
            ),


            

            // TEMP NUMBER
            Padding(padding: EdgeInsets.all(7.0),
            child: 
            
              Row(children : <Widget>[

                RichText(

                  text: 
                

                TextSpan(children: [

                    TextSpan(
                      text: '${widget.rain}',
                      style: TextStyle(
                        color: Color.fromARGB(221, 255, 255, 255),
                        shadows: [
                            BoxShadow(blurRadius: 2.3, offset: Offset(0.1, 0.2),color: const Color.fromARGB(255, 0, 0, 0)).scale(1.5)
                        ],
                      ),
                  ),

                  TextSpan(
                      text: ' %',
                      style: TextStyle(
                        color: Color.fromARGB(221, 255, 255, 255),
                      ),
                  ),


                ]),
                ),


                // Text(
                //   '${widget.rain}',
                //   style: TextStyle(
                //     fontSize: 20.0,
                //     color: const Color.fromARGB(221, 255, 255, 255),
                //     shadows: [
                //       // Shadow(blurRadius: 0.01, offset: Offset(5, 5),color: Colors.black12),
                //       BoxShadow(blurRadius: 3.9, offset: Offset(0.1, 0.2),color: const Color.fromARGB(255, 0, 0, 0)).scale(2),
                      
                //     ],
                //     ),
                // )
              ]),
            
            ),
            
            
            

          ],
        ),




      ),
    );

  }
}