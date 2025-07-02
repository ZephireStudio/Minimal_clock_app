import 'package:minimal_clock/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class Theme2 extends StatefulWidget {
  const Theme2({super.key});

  @override
  State<Theme2> createState() => _Theme2State();
}

class _Theme2State extends State<Theme2> {
  String _timeString = '';
  String _meridiemString = '';
  late Timer _timer; // Timer Object to update time periodically

  String _getTime() { // This is a formatting function
    final DateTime now = DateTime.now();
    final String formattedTime = DateFormat('hh : mm').format(now);
    final String meridiem = DateFormat('a').format(now); // Gets am/pm
    setState(() {
      _timeString = formattedTime;
      _meridiemString = meridiem;
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background/theme2background.png'),
            fit: BoxFit.cover,
            )
        ),

        child: SafeArea(
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

                     Expanded(
                    flex: 1,
                    child: Container(), // This pushes content up
                  ),
                      Text(
                      _timeString,
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 160,
                        fontWeight: FontWeight.bold,  // w700
                        color: Colors.white
                      )
                    ),
        
                    Text(
                      _meridiemString,
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 30,
                        fontWeight: FontWeight.w400,  // Regular weight
                        color: Colors.white
                      ),
                    ),

                     Expanded(
                    flex: 1,
                    child: Container(), // This pushes content up
                  ),
                  ]
                )
              ),
            ],
          )
        ),
      ),
    );
  }
}