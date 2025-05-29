class TimerState {
  final int remainingSeconds;
  final bool isRunning;

  TimerState({required this.remainingSeconds, required this.isRunning});

  TimerState copyWith({
    int? remainingSeconds,
    bool? isRunning,
  }) {
    return TimerState(
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      isRunning: isRunning ?? this.isRunning,
    );
  }
}
