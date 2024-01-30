import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:ggc/presentation/components/overlay_screen.dart';
import 'package:ggc/presentation/sample/sample_game.dart';
import 'package:google_fonts/google_fonts.dart';

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  late final SampleGame game;

  @override
  void initState() {
    super.initState();
    game = SampleGame();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.pressStart2pTextTheme().apply(
          bodyColor: const Color(0xff184e77),
          displayColor: const Color(0xff184e77),
        ),
      ),
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GameWidget.controlled(
              gameFactory: SampleGame.new,
              overlayBuilderMap: {
                // overlays.addで追加した名前をキーにして、
                // その名前に対応するWidgetを返す
                PlayState.welcome.name: (context, game) => const OverlayScreen(
                      title: 'TAP TO PLAY',
                      subtitle: 'Use arrow keys or swipe',
                    ),
                PlayState.gameOver.name: (context, game) => const OverlayScreen(
                      title: 'G A M E   O V E R',
                      subtitle: 'Tap to Play Again',
                    ),
                PlayState.won.name: (context, game) => const OverlayScreen(
                      title: 'Y O U   W O N ! ! !',
                      subtitle: 'Tap to Play Again',
                    ),
              },
            ),
          ),
        ),
      ),
    );
  }
}
