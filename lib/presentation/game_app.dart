import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:ggc/presentation/component/google_wallet_button.dart';
import 'package:ggc/presentation/components/overlay_screen.dart';
import 'package:ggc/presentation/components/score_card.dart';
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
        textTheme: GoogleFonts.delaGothicOneTextTheme().apply(
          bodyColor: const Color.fromARGB(255, 24, 78, 119),
          displayColor: Colors.yellow.shade300,
        ),
      ),
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              ScoreCard(score: game.score),
              Expanded(
                child: GameWidget(
                  game: game,
                  overlayBuilderMap: {
                    // overlays.addで追加した名前をキーにして、
                    // その名前に対応するWidgetを返す
                    PlayState.welcome.name: (context, game) =>
                        const OverlayScreen(
                          title: 'タップでゲーム開始',
                          subtitle: 'スマホを傾けてカメを動かそう！',
                        ),

                    PlayState.gameOver.name: (context, SampleGame game) =>
                        OverlayScreen(
                          title: 'ゲームオーバー',
                          subtitle: 'タップで再挑戦！',
                          child: GoogleWalletButton(
                            score: game.score.value.toString(),
                          ),
                        ),
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
