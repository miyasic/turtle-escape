import 'package:flutter/material.dart';
import 'package:ggc/constants/values.dart';
import 'package:ggc/presentation/game/turtle_escape.dart';
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
        final rank = ScoreClass.fromInt(score);
        return DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(100, 160, 160, 1),
                Color.fromRGBO(100, 180, 180, 1),
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
                score != 0
                    ? Text(
                        rank.rankText,
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        );
      },
    );
  }
}
