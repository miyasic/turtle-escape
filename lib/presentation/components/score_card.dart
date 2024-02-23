import 'package:flutter/material.dart';
import 'package:ggc/util/format_duration.dart';

class ScoreCard extends StatelessWidget {
  const ScoreCard({
    super.key,
    required this.score,
  });

  final ValueNotifier<int> score;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: score,
      builder: (context, score, child) {
        final formatted = formatDuration(score);
        return DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(90, 170, 170, 1),
                Color.fromRGBO(120, 190, 190, 1),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'スコア : ',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 110),
                  child: Text(
                    '$formatted秒',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
