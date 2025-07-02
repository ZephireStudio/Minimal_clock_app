import 'package:minimal_clock/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class Theme1 extends StatefulWidget {
  const Theme1({super.key});

  @override
  State<Theme1> createState() => _Theme1State();
}

class _Theme1State extends State<Theme1> {
  String _timeString = '';
  String _dateString = '';
  String _weekDayString = '';
  String _meridiemString = '';
  late Timer _timer; // Timer Object to update time periodically

  String _getTime() { // This is a formatting function
    final DateTime now = DateTime.now();
    final String formattedTime = DateFormat('hh  :  mm').format(now);
    final String meridiem = DateFormat('a').format(now); // Gets am/pm
    final String formattedDate = DateFormat('dd MMM').format(now);
    final String weekDay = DateFormat('EEEE').format(now);
    setState(() {
      _timeString = formattedTime;
      _meridiemString = meridiem;
      _dateString = formattedDate.toUpperCase();
      _weekDayString = weekDay.toUpperCase();
    });
    return formattedTime;
  }

  @override
  void initState() {
    super.initState();
    _timeString = _getTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
  }

  @override
  void dispose(){
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // T H E M E  O F  T H E  A P P

    return Scaffold(
      
      // D R A W E R
      drawer: AppDrawer(),

      body: Container(

        // background
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background/sunrise.jpg'),
            fit: BoxFit.cover,
            )
        ),
      
        child: SafeArea(
          child: Stack(
            children: [

              Positioned(
                left: 10,
                top: 10,
                child: Builder(builder: (context)=> 
                IconButton(
                  onPressed: () =>Scaffold.of(context).openDrawer(), 
                  icon: Icon(Icons.menu, color: ColorScheme.of(context).onBackground,)))),
              
              // Time
              Column(
                children: [
                  
                  Expanded(
                    flex: 1,
                    child: Container(),
                    ),
                                        
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        
                      Center(
                        child: Text(
                          _timeString,
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 105,
                            color: Colors.white,
                            height: 1.0, // Reduces vertical space
                          ),
                        ),
                      ),
                      
                      const SizedBox(width: 10),
                                          
                    Padding(
                      padding: EdgeInsets.only(top: 55),
                      child: Text(
                        _meridiemString,
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 30,
                          color: Colors.white,
                          height: 1.0,
                            ),
                          ),
                        ),
                      ], // Children
                    ),
                  ),
                                        
                  const SizedBox(height: 20),

                  // W E E K  A N D  D A T E 
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(right: 50),
                          child: Text(
                            "$_weekDayString, $_dateString",
                            style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 28,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(flex: 1,child: Container())
                ]
              ),
            ]
          )
        ),
      ),
    );
  }
}