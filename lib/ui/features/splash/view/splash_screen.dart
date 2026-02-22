import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truck_mandi/ui/core/theme/color.dart';
import 'package:truck_mandi/configs/utils/extensions.dart';
import 'package:truck_mandi/ui/features/splash/view_model/splash_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<double> _fadeOut;
  late Animation<double> _zoomOut;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600), // full animation time
    );

    // ---- Animation Segments ----
    // 1) Fade In (0 → 0.4 interval)
    _fadeIn = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );

    // 2) Fade Out (0.6 → 1.0 interval)
    _fadeOut = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
      ),
    );

    // 3) Zoom Out (0.6 → 1.0 interval)
    _zoomOut = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
      ),
    );

    // Start animation
    _controller.forward();

    // Navigate after full animation
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        context.read<SplashViewModel>().checkAuthentication(context);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            // Combine fade in + fade out
            double opacity = _fadeIn.value * _fadeOut.value;

            return Opacity(
              opacity: opacity,
              child: Transform.scale(scale: _zoomOut.value, child: child),
            );
          },
          child: Image.asset(
            'assets/images/splash.png',
            height: context.mediaQueryHeight / 2.5,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
