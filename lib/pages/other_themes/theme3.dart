import 'package:minimal_clock/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class Theme3 extends StatefulWidget {
  const Theme3({super.key});

  @override
  State<Theme3> createState() => _Theme3State();
}

class _Theme3State extends State<Theme3> {
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
      return Scaffold(
      drawer: AppDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(246, 231, 230, 1),
              Color.fromRGBO(231, 211, 204, 1),
            ],
          ),
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
                icon: Icon(Icons.menu, color: Colors.grey.shade800,)))),

              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _timeString,
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 85,
                        fontWeight: FontWeight.w300,  // Light weight for elegance
                        color: Color(0xFF4A4A4A),
                        letterSpacing: -2,  // Tighter spacing for large text
                      ),
                    ),
                    Text(
                      _meridiemString,
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 24,
                        fontWeight: FontWeight.w400,  // Regular weight
                        color: Color(0xFF6D6D6D),
                        letterSpacing: 4,  // Keep the wide spacing for AM/PM
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}