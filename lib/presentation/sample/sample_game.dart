import 'dart:async';
import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:ggc/presentation/components/fish.dart';
import 'package:ggc/presentation/components/moving_range.dart';
import 'package:ggc/presentation/components/play_area.dart';
import 'package:ggc/presentation/components/trash.dart';

enum PlayState { welcome, playing, gameOver, won }

class SampleGame extends FlameGame
    with HasCollisionDetection, KeyboardEvents, TapDetector {
  SampleGame() : super();

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
        world.removeAll(world.children.query<Trash>());
        world.removeAll(world.children.query<TimerComponent>());
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

    // デバイスの画面サイズを取得
    final screenSize = size;

    // カメラのビューポートをデバイスの画面サイズに設定
    camera.viewport = FixedResolutionViewport(resolution: screenSize);

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
    world.add(MovingRange());

    addTrash();

    // TODO: 最初はゆっくり追加して、徐々に感覚を狭める
    // 1秒ごとにゴミを追加
    world.add(
      TimerComponent(
        period: 1,
        repeat: true,
        onTick: () {
          if (playState == PlayState.playing) {
            addTrash();
          }
        },
      ),
    );
  }

  void addTrash() {
    final trash = Trash();
    world.add(trash);
  }

  @override
  void onTap() {
    super.onTap();
    // タップしたらゲームを開始
    startGame();
  }

  @override
  Color backgroundColor() => const Color(0xfff2e8cf);

  MovingRange? findMovingRange() {
    return world.children.firstWhereOrNull((element) => element is MovingRange)
        as MovingRange?;
  }

  Fish? findFishFromMovingRange() {
    final movingRange = world.children
        .firstWhereOrNull((element) => element is MovingRange) as MovingRange?;
    if (movingRange == null) {
      return null;
    }
    return movingRange.findFish();
  }
}
