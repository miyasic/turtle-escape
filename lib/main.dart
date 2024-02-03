import 'package:flutter/material.dart';
import 'package:ggc/presentation/game_app.dart';
import 'package:ggc/util/provider_logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(ProviderScope(observers: [ProviderLogger()], child: const GameApp()));
}
