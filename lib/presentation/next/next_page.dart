import 'package:flutter/material.dart';
import 'package:ggc/constants/route_path.dart';
import 'package:ggc/constants/text_style.dart';
import 'package:ggc/gen/assets.gen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

class NextPage extends ConsumerWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kPageNameNext),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              kPageNameNext,
              style: textStylePlain,
            ),
            Lottie.asset(Assets.lottie.programming),
          ],
        ),
      ),
    );
  }
}
