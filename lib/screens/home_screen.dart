import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/timer_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _bgAnimationController;
  late Animation<Color?> _color1;
  late Animation<Color?> _color2;

  @override
  void initState() {
    super.initState();

    _bgAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);

    _color1 = ColorTween(
      begin: const Color(0xFFB2FEFA),
      end: const Color(0xFF0ED2F7),
    ).animate(_bgAnimationController);

    _color2 = ColorTween(
      begin: const Color(0xFF0ED2F7),
      end: const Color(0xFFF8B195),
    ).animate(_bgAnimationController);
  }

  @override
  void dispose() {
    _bgAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timerState = ref.watch(timerProvider);

    final String minutes =
        (timerState.remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final String seconds =
        (timerState.remainingSeconds % 60).toString().padLeft(2, '0');

    return AnimatedBuilder(
      animation: _bgAnimationController,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_color1.value!, _color2.value!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    right: 20,
                    child: IconButton(
                      icon: const Icon(Icons.settings, color: Colors.black87),
                      onPressed: () {
                        Navigator.pushNamed(context, '/settings');
                      },
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      Text(
                        "🧘‍♂️ Focus Time - $minutes:$seconds",
                        style: GoogleFonts.raleway(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 18, 0, 0)
                              .withAlpha(242),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Container(
                        width: 220,
                        height: 220,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(25),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withAlpha(76),
                            width: 4,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withAlpha(25),
                              blurRadius: 20,
                              spreadRadius: 4,
                            )
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "$minutes:$seconds",
                          style: GoogleFonts.raleway(
                            fontSize: 36,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromARGB(255, 12, 12, 12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _actionButton("Start", Icons.play_arrow),
                          const SizedBox(width: 20),
                          _actionButton("Pause", Icons.pause),
                          const SizedBox(width: 20),
                          _actionButton("Reset", Icons.replay),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Text(
                        "Calm your mind and breathe... 🌿",
                        style: GoogleFonts.raleway(
                          fontSize: 16,
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _actionButton(String label, IconData icon) {
    final timer = ref.read(timerProvider.notifier);

    return ElevatedButton.icon(
      onPressed: () {
        if (label == "Start") {
          timer.startTimer();
        } else if (label == "Pause") {
          timer.pauseTimer();
        } else if (label == "Reset") {
          timer.resetTimer();
        }
      },
      icon: Icon(icon, color: Colors.white),
      label: Text(
        label,
        style: GoogleFonts.raleway(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black.withAlpha(76),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 8,
      ),
    );
  }
}
