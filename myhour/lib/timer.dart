import 'dart:async';
import './timermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class CountDownTimer {
  double _radius = 1;
  bool _isActive = true;
  Timer timer;
  Duration _time;
  Duration _fullTime;

  int work = 30;
  int shortBreak = 5;
  int longBreak = 20;

  String returnTime(Duration t) {
    String minutes = (t.inMinutes < 10)
        ? '0' + t.inMinutes.toString()
        : t.inMinutes.toString();
    t.inMinutes.toString();
    int numSeconds = t.inSeconds - (t.inMinutes * 60);
    String seconds =
        (numSeconds < 10) ? '0' + numSeconds.toString() : numSeconds.toString();
    String fTime = minutes + ":" + seconds;
    return fTime;
  }

  Stream<TimerModel> stream() async* {
    yield* Stream.periodic(Duration(seconds: 1), (int a) {
      String time;
      if (this._isActive) {
        _time = _time - Duration(seconds: 1);
        _radius = _time.inSeconds / _fullTime.inSeconds;
        if (_time.inSeconds <= 0) {
          FlutterRingtonePlayer.playNotification();
          FlutterRingtonePlayer.play(
            android: AndroidSounds.notification,
            ios: IosSounds.glass,
            looping: true,
            volume: 1.0,
          );
          _isActive = false;
        }
      }
      time = returnTime(_time);
      return TimerModel(time, _radius);
    });
  }

  void startWork() async {
    await readSettings();
    _radius = 1;
    _time = Duration(minutes: this.work, seconds: 0);
    _fullTime = _time;
  }

  void stopTimer() {
    this._isActive = false;
    FlutterRingtonePlayer.stop();
  }

  void startTimer() {
    if (_time.inSeconds > 0) {
      this._isActive = true;
    }
  }

  void startBreak(bool tipo) {
    _radius = 1;
    _time = Duration(minutes: (tipo) ? shortBreak : longBreak, seconds: 0);
    _fullTime = _time;
  }

  Future readSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    work = prefs.getInt('workTime') == null ? 30 : prefs.getInt('workTime');
    shortBreak =
        prefs.getInt('shortBreak') == null ? 5 : prefs.getInt('shortBreak');
    longBreak =
        prefs.getInt('longBreak') == null ? 20 : prefs.getInt('longBreak');
  }
}
