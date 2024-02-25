import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ggc/services/shared_preferences_service.dart';
import 'package:ggc/util/format_duration.dart';

class OverlayScreen extends StatelessWidget {
  const OverlayScreen({
    super.key,
    required this.title,
    required this.subtitle,
    this.child,
    required this.hiScores,
  });

  final String title;
  final String subtitle;
  final Widget? child;
  final List<Score> hiScores;

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
          if (hiScores.isNotEmpty)
            Column(
              children: [
                const SizedBox(height: 16),
                Text(
                  'ハイスコア',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.yellow.shade300,
                      ),
                ),
                const SizedBox(height: 8),
                for (var i = 0; i < hiScores.length; i++)
                  Row(
                    children: [
                      const Spacer(),
                      Text(
                        '${i + 1}位: ${formatDuration(hiScores[i].$1)}秒',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.yellow.shade300,
                            ),
                      ),
                      hiScores[i].$3
                          ? Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  hiScores[i].$2 ? '✨新記録✨' : 'ランクイン',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                            )
                          : const Spacer(),
                    ],
                  ),
              ],
            ),
          const SizedBox(height: 16),
          child ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
