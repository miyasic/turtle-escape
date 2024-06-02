import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ggc/presentation/component/google_wallet_button.dart';
import 'package:ggc/presentation/component/privacy_policy_button.dart';
import 'package:ggc/presentation/components/overlay_screen.dart';
import 'package:ggc/presentation/components/score_card.dart';
import 'package:ggc/presentation/game/turtle_escape.dart';
import 'package:google_fonts/google_fonts.dart';

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  late final TurtleEscape game;

  @override
  void initState() {
    super.initState();
    game = TurtleEscape();
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
                    PlayState.welcome.name: (context, TurtleEscape game) =>
                        OverlayScreen(
                          title: '画面タップでゲーム開始',
                          subtitle: 'スマホを傾けてカメを動かそう！',
                          hiScores: game.highScores.value,
                          child: const PrivacyPolicyButton(),
                        ),

                    PlayState.gameOver.name: (context, TurtleEscape game) =>
                        OverlayScreen(
                          title: 'ゲームオーバー',
                          subtitle: '画面タップで再挑戦！',
                          hiScores: game.highScores.value,
                          child: Column(
                            children: [
                              GoogleWalletButton(
                                score: game.score.value,
                              ),
                              const Gap(8),
                              const PrivacyPolicyButton(),
                            ],
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
