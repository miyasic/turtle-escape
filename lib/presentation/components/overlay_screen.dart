import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OverlayScreen extends StatelessWidget {
  const OverlayScreen({
    super.key,
    required this.title,
    required this.subtitle,
    this.child,
  });

  final String title;
  final String subtitle;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(0, -0.15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
          ).animate().slideY(duration: 750.ms, begin: -3, end: 0),
          const SizedBox(height: 16),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.yellow.shade300,
                ),
            textAlign: TextAlign.center,
          )
              .animate(onPlay: (controller) => controller.repeat())
              .fadeIn(duration: 1.seconds)
              .then()
              .fadeOut(duration: 1.seconds),
          const SizedBox(height: 16),
          child ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
