import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:lottie/lottie.dart';

class StaticTimeDisplay extends StatefulWidget {
  const StaticTimeDisplay({super.key});

  @override
  State<StaticTimeDisplay> createState() => _StaticTimeDisplayState();
}

class _StaticTimeDisplayState extends State<StaticTimeDisplay> {
  String _timeString = '';
  String _dateString = '';
  String _weekDayString = '';
  late Timer _timer; // Timer Object to update time periodically

  String _getTime() {
    // This is a formating function
    final DateTime now = DateTime.now();
    final String formattedTime = DateFormat('hh : mm').format(now);
    final String formattedDate = DateFormat('dd MMM, yyyy').format(now);
    final String weekDay = DateFormat('EEEE').format(now);
    setState(() {
      _timeString = formattedTime;
      _dateString = formattedDate;
      _weekDayString = weekDay;
    });
    return formattedTime;
  }

  @override
  void initState() {
    super.initState();
    _timeString = _getTime();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer t) => _getTime(),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // fix for dark Mode
          // Lottie.asset('assets/animation/clockAnimation.json', height: 400.r, width: 400.r, repeat: false),
          Icon(
            Icons.access_time_filled_outlined,
            color: ColorScheme.of(context).onSurface,
            size: 340.r,
          ),

          SizedBox(height: 10.r),

          Text(
            _timeString,
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 380.r,
              fontWeight: FontWeight.w400, // Bold weight
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 5.5.r),

          Text(
            _weekDayString,
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 190.r,
              fontWeight: FontWeight.w400, // Medium weight
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 0.r),

          Text(
            _dateString,
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 60.r,
              fontWeight: FontWeight.w100, // Medium weight
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
