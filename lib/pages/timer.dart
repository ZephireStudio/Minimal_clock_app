import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:lottie/lottie.dart';
import 'package:minimal_clock/services/timer_service.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:minimal_clock/components/drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTimer extends StatefulWidget {
  const CustomTimer({super.key});

  @override
  State<CustomTimer> createState() => _CustomTimerState();
}

class _CustomTimerState extends State<CustomTimer> {
  final TimerService _timerService = TimerService();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    WakelockPlus.enable();
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // String theme =
    //     isDarkMode
    //         ? 'assets/animation/boatAnimation_dark.json'
    //         : 'assets/animation/boatAnimation_light.json';

    return Scaffold(
      drawer: AppDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: 10,
              top: 10,
              child: Builder(
                builder:
                    (context) => IconButton(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: Icon(
                        Icons.menu,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
              ),
            ),
            Center(
              child: ListenableBuilder(
                listenable: _timerService,
                builder: (context, _) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Animation
                      // Lottie.asset(theme, height: 700.r, width: 700.r),
                      
                      Text(
                        // Timer
                        _timerService.formatStopwatchTime(),
                        style: TextStyle(
                          fontSize: 315.r, // Add .sp here
                          fontFamily: 'Outfit',
                        ),
                      ),
                      SizedBox(height: 20.h), // Add .h here
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_timerService.isStopwatchRunning) {
                                _timerService.pauseStopwatch();
                              } else {
                                _timerService.startStopwatch();
                              }
                            },
                            child: Icon(
                              _timerService.isStopwatchRunning
                                  ? Icons.stop
                                  : Icons.play_arrow,
                              size:
                                  100.r, // Add .r here for proportional sizing
                            ),
                          ),
                          SizedBox(width: 20.w), // Add .w here
                          ElevatedButton(
                            onPressed: _timerService.resetStopwatch,
                            child: Icon(Icons.restore, size: 100.r),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
