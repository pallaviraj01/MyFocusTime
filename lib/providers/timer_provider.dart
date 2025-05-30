import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/timer_state.dart';
import '../services/notification_service.dart';

final timerProvider = StateNotifierProvider<TimerNotifier, TimerState>((ref) {
  return TimerNotifier();
});

class TimerNotifier extends StateNotifier<TimerState> {
  TimerNotifier() : super(TimerState(remainingSeconds: 1500, isRunning: false));

  Timer? _timer;

  void startTimer() {
    if (state.isRunning) return;

    state = state.copyWith(isRunning: true);

    // Show initial notification when starting
    NotificationService.showTimerNotification(_formattedTime());

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingSeconds == 0) {
        _timer?.cancel();
        state = state.copyWith(isRunning: false);
        NotificationService.cancelNotification(); // Cancel notification when finished
      } else {
        state = state.copyWith(remainingSeconds: state.remainingSeconds - 1);
        // Update notification with new time
        NotificationService.showTimerNotification(_formattedTime());
      }
    });
  }

  //  void startTimer() {
  //   if (state.isRunning) return;

  //   state = state.copyWith(isRunning: true);

  //   // Show initial notification with sound/vibration
  //   NotificationService.showTimerNotification(_formattedTime());

  //   _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //     if (state.remainingSeconds == 0) {
  //       _timer?.cancel();
  //       state = state.copyWith(isRunning: false);
  //       NotificationService.cancelNotification();
  //     } else {
  //       state = state.copyWith(remainingSeconds: state.remainingSeconds - 1);
  //       // Update notification silently on each tick
  //       NotificationService.updateTimerNotification(_formattedTime());
  //     }
  //   });
  // }

  

  void pauseTimer() {
    _timer?.cancel();
    state = state.copyWith(isRunning: false);
    NotificationService.cancelNotification(); // Cancel when paused
  }

  void resetTimer() {
    _timer?.cancel();
    state = TimerState(remainingSeconds: 1500, isRunning: false);
    NotificationService.cancelNotification(); // Cancel when reset
  }

  String _formattedTime() {
    final min = (state.remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final sec = (state.remainingSeconds % 60).toString().padLeft(2, '0');
    return '$min:$sec';
  }
}
