import 'package:minimal_clock/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class Theme4 extends StatefulWidget {
  const Theme4({super.key});

  @override
  State<Theme4> createState() => _Theme4State();
}

class _Theme4State extends State<Theme4> {
  String _timeString = '';
  String _dateString = '';
  String _weekDayString = '';
  String _meridiemString = '';
  late Timer _timer; // Timer Object to update time periodically

  String _getTime() { // This is a formatting function
    final DateTime now = DateTime.now();
    final String formattedTime = DateFormat('hh : mm').format(now);
    final String meridiem = DateFormat('a').format(now); // Gets am/pm
    final String formattedDate = DateFormat('dd MMM yyyy').format(now);
    final String weekDay = DateFormat('EEEE').format(now);
    setState(() {
      _timeString = formattedTime;
      _meridiemString = meridiem;
      _dateString = formattedDate;
      _weekDayString = weekDay;
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

      backgroundColor: Colors.amber[300],
      body: SafeArea(
        child: Stack(
          children: [

            Positioned(
              left: 10,
              top: 10,
              child: Builder(builder: (context)=> IconButton(onPressed: () =>Scaffold.of(context).openDrawer(), icon: Icon(Icons.menu, color: Colors.white,)))),

            // Time
            Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),

                    Text(
                    _timeString,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 100,
                      fontWeight: FontWeight.bold,  // w700
                      color: Colors.white
                    ),
                  ),

                  Text(
                    _meridiemString,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.white
                    ),
                  ),


                  const SizedBox(height: 40),
          
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Added center alignment
                    children: [

                      // Weekday
                      Text(
                        _weekDayString,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(width: 300), // Changed from height to width

                      // Date
                      Text(
                        _dateString,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                ]
              )
            ),
          ],
        )
      ),
    );
  }
}