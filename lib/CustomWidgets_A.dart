import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';

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
                  ),

              ),
              Text(
                '°',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white, 
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
  
  final List<int> temps;
  final int temp;
  final String time;
  
  const Boxule2(this.temps, this.temp, this.time, {super.key});

  @override
  State<Boxule2> createState() => _boxule2State();
}

class _boxule2State extends State<Boxule2> {
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
              ),
              Text(
                widget.time.substring(widget.time.length - 2, widget.time.length), 
                style: TextStyle(fontSize: 7.0 ),
              )
                  ],
            ),

            // TEMP VISUAL -----
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
                Container(
                  width: 79,
                  height: 77,
                  color: const Color.fromARGB(255, 7, 7, 7),
                ),
                Container(
                  width: 70,
                  height: 70,
                  color: const Color.fromARGB(255, 239, 228, 227),
                ),

                // INSERT ARROW SYMBOLL HERE  

                Container(
                  width: 5,
                  height: tempVisual,//50,
                  color: const Color.fromARGB(255, 198, 4, 78),
                ),
              ],
            ),

            // TEMP NUMBER
            Row(children : <Widget>[
                Text(
                  '${widget.temp}'
              ),
              Text(
                '°',
                style: TextStyle(fontSize: 20.0 ),
              )
            ]),
            
            
            

          ],
        ),




      ),
    );












  }
}
