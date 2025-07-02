import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class TimerService extends ChangeNotifier {
  // For pomo rounds
  int totalRounds = 1;
  int currentRound = 0;


  void setTotalRounds(int rounds){
    totalRounds = rounds;
    notifyListeners();
  }

  void _handleRoundCompletion(){
    if(!isBreak){
      currentRound++;
      notifyListeners();
    }
  }

  static final TimerService _instance = TimerService._internal();
  factory TimerService() => _instance;
  TimerService._internal();

  final AudioPlayer _audioPlayer = AudioPlayer();

  // Pomodoro timer values
  static const int pomoDuration = 25 * 60;
  static const int breakDuration = 5 * 60;
  int _pomoTimeLeft = pomoDuration;
  bool _isPomoRunning = false;
  bool _isBreak = false;
  Timer? _pomoTimer;
  double _start_break_Volume = 0.5;
  double _end_break_Volume = 0.5;

  // Stopwatch timer values
  Duration _stopwatchTime = Duration.zero;
  bool _isStopwatchRunning = false;
  Timer? _stopwatchTimer;

  // Getters
  int get pomoTimeLeft => _pomoTimeLeft;
  bool get isPomoRunning => _isPomoRunning;
  bool get isBreak => _isBreak;
  Duration get stopwatchTime => _stopwatchTime;
  bool get isStopwatchRunning => _isStopwatchRunning;
  //volume control getters
  double get startvolume => _start_break_Volume;
  double get endVolume => _end_break_Volume;


  //setter for volume control
  set startvolume(double value){
    _start_break_Volume = value.clamp(0.0, 1.0);
    notifyListeners();
  }

  set endVolume(double value){
    _end_break_Volume = value.clamp(0.0, 2.5);
    notifyListeners();
  }

  void _playNotificationSound() async {
    try {
      // WHEN BREAK START
      if (_isBreak) {
        final player = AudioPlayer();
        await player.setVolume(_start_break_Volume);
        await player.play(AssetSource('sounds/start.mp3'));
        player.onPlayerComplete.listen((event) {
          player.dispose();});
      }
      // WHEN BREAK END
      else {
        final player = AudioPlayer();
        await player.setVolume(_end_break_Volume);
        await player.play(AssetSource('sounds/end.mp3'));
        player.onPlayerComplete.listen((event) {
          player.dispose();
        });
      }
    } catch (e) {
      print('Caught error while playing sound: $e');
    }
  }

  // Pomodoro methods
  void startPomodoroTimer() {
    if (_pomoTimer != null) return;

    _pomoTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_pomoTimeLeft > 0) {
        _pomoTimeLeft--;
        notifyListeners();
      } else {
        _pomoTimer?.cancel();
        _pomoTimer = null;
        _isPomoRunning = false;
        _playNotificationSound();

        if (!_isBreak) {
          _handleRoundCompletion();
          if (currentRound >= totalRounds && !_isBreak){
            _pomoTimeLeft = pomoDuration;
            _isBreak = false;
            currentRound = 0;
            return; // stop if all rounds are completed
          }
          _isBreak = true;
          _pomoTimeLeft = breakDuration;
          startPomodoroTimer();
        } else {
          _isBreak = false;
          _pomoTimeLeft = pomoDuration;
          startPomodoroTimer();
        }
      }
      notifyListeners();
    });
    _isPomoRunning = true;
    notifyListeners();
  }

  void pausePomodoroTimer() {
    _pomoTimer?.cancel();
    _pomoTimer = null;
    _isPomoRunning = false;
    notifyListeners();
  }

  void resetPomodoroTimer() {
    _pomoTimer?.cancel();
    _pomoTimer = null;
    _pomoTimeLeft = pomoDuration;
    _isPomoRunning = false;
    _isBreak = false;
    currentRound = 0;
    notifyListeners();
  }

  // Stopwatch methods
  void startStopwatch() {
    if (_stopwatchTimer != null) return;

    _stopwatchTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _stopwatchTime = _stopwatchTime + const Duration(seconds: 1);
      notifyListeners();
    });
    _isStopwatchRunning = true;
    notifyListeners();
  }

  void pauseStopwatch() {
    _stopwatchTimer?.cancel();
    _stopwatchTimer = null;
    _isStopwatchRunning = false;
    notifyListeners();
  }

  void resetStopwatch() {
    _stopwatchTimer?.cancel();
    _stopwatchTimer = null;
    _stopwatchTime = Duration.zero;
    _isStopwatchRunning = false;
    notifyListeners();
  }

  String formatPomodoroTime() {
    int minutes = _pomoTimeLeft ~/ 60;
    int seconds = _pomoTimeLeft % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String formatStopwatchTime() {
    Duration duration = stopwatchTime;
    int hours = duration.inHours;
    int minutes = (duration.inMinutes % 60);
    int seconds = (duration.inSeconds % 60);

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr';
  }

  @override
  void dispose() {
    _pomoTimer?.cancel();
    _stopwatchTimer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }
}
