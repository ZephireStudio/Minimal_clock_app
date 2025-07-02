import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minimal_clock/components/drawer.dart';
import 'package:minimal_clock/services/timer_service.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class Pomodoro extends StatefulWidget {

  Pomodoro({super.key});

  @override
  State<Pomodoro> createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  final TimerService _timerService = TimerService();
  final TextEditingController _roundsController = TextEditingController(text: '1');

  @override
  void initState(){
    super.initState();
    WakelockPlus.enable();
  }

  @override
  void dispose() {
    _roundsController.dispose();
    _timerService.dispose();
    super.dispose();
  }

  // Add this widget between the "Work Time"/"Break Timer" text and the timer display
  Widget _buildRoundsInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (!_timerService.isPomoRunning) ...[
          SizedBox(
            width: 340.r,
            child: TextField(
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 80.r,
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w200
              ),
              controller: _roundsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Rounds',
                labelStyle: TextStyle(fontSize: 60.r),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                int? rounds = int.tryParse(value);
                if (rounds != null && rounds > 0) {
                  _timerService.setTotalRounds(rounds);
                }
              },
            ),
          ),
        ] else ...[
          Text(
            'Round ${_timerService.currentRound + 1}/${_timerService.totalRounds}',
            style: TextStyle(
              fontSize: 50.r,
              fontFamily: "Outfit",
            ),
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: AppDrawer(),

      body: Center(
        child: Stack(
          children: [
            Positioned(
                left: 10.r,
                top: 10.r,
                child: Builder(builder: (context)=> 
                IconButton(
                  onPressed: () =>Scaffold.of(context).openDrawer(), 
                  icon: Icon(Icons.menu, color: ColorScheme.of(context).onBackground,)))),

            ListenableBuilder(
              listenable: _timerService,
              builder: (context, _){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                
                    Text(
                      _timerService.isBreak ? "Break Timer" : "Work Time",
                      style: TextStyle(
                        fontSize: 180.r,
                        fontFamily: "Outfit"
                      ),
                    ),

                    SizedBox(height: 50.r,),
                
                    _buildRoundsInfo(), // Add this line
                
                    Text(
                      _timerService.formatPomodoroTime(),
                      style: TextStyle(
                        fontSize: 400.r,
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                
                    SizedBox(height: 40.r,),
                
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(onPressed: (){
                          if (_timerService.isPomoRunning){
                            _timerService.pausePomodoroTimer();
                          } else {
                            _timerService.startPomodoroTimer();
                          }
                        }, 
                        child: Icon(_timerService.isPomoRunning ? Icons.stop : Icons.play_arrow_rounded, size: 140.r,)),
                
                        SizedBox(width: 10.r,),
                
                        ElevatedButton(onPressed: _timerService.resetPomodoroTimer, child: Icon(Icons.restore, size: 140.r,)),
                      ],
                    )
                  ],
                );
              },
            ),
          ]
        ),
      ),
    );
  }
}