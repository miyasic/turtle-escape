import 'dart:async';
import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:ggc/presentation/components/moving_range.dart';
import 'package:ggc/presentation/components/play_area.dart';
import 'package:ggc/presentation/components/trash.dart';

enum PlayState { welcome, playing, gameOver, won }

class SampleGame extends FlameGame
    with HasCollisionDetection, KeyboardEvents, TapDetector {
  SampleGame()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: 360,
            height: 640,
          ),
        );

  final ValueNotifier<int> score = ValueNotifier(0);
  final rand = math.Random();
  double get width => size.x;
  double get height => size.y;

  late PlayState _playState;
  PlayState get playState => _playState;
  set playState(PlayState playState) {
    _playState = playState;
    switch (playState) {
      case PlayState.welcome:
      case PlayState.gameOver:
      case PlayState.won:
        overlays.add(playState.name);
      case PlayState.playing:
        overlays.remove(PlayState.welcome.name);
        overlays.remove(PlayState.gameOver.name);
        overlays.remove(PlayState.won.name);
    }
  }

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    // worldはゲーム画面のこと
    world.add(PlayArea());

    playState = PlayState.welcome;

    // デバッグモードを有効にする
    debugMode = true;
  }

  void startGame() {
    if (playState == PlayState.playing) {
      return;
    }
    world
      ..removeAll(world.children.query<MovingRange>())
      ..removeAll(world.children.query<Trash>());

    playState = PlayState.playing;
    score.value = 0;

    // 行動範囲を表示
    world
      ..add(MovingRange())
      ..add(Trash()); // TODO: ゴミをランダムに複数永続的にaddする
  }

  @override
  void onTap() {
    super.onTap();
    // タップしたらゲームを開始
    startGame();
  }

  @override
  Color backgroundColor() => const Color(0xfff2e8cf);
}
