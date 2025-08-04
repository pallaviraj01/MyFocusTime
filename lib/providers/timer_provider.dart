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

    // Show ONE persistent notification (not repeating every second)
    NotificationService.showPersistentNotification();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingSeconds == 0) {
        _timer?.cancel();
        state = state.copyWith(isRunning: false);
        NotificationService.cancelNotification();
      } else {
        state = state.copyWith(remainingSeconds: state.remainingSeconds - 1);
        // No notification update here anymore
      }
    });
  }


  void pauseTimer() {
    _timer?.cancel();
    state = state.copyWith(isRunning: false);
    NotificationService.cancelNotification();
  }

  void resetTimer() {
    _timer?.cancel();
    state = TimerState(remainingSeconds: 1500, isRunning: false);
    NotificationService.cancelNotification();
  }

}
