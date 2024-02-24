import 'dart:async';
import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:ggc/presentation/components/play_area.dart';
import 'package:ggc/presentation/components/sea_turtle.dart';
import 'package:ggc/presentation/components/trash/bottle.dart';
import 'package:ggc/presentation/components/trash/plastic_bag.dart';
import 'package:ggc/presentation/components/trash/straw.dart';

enum PlayState { welcome, playing, gameOver }

class SampleGame extends FlameGame with HasCollisionDetection, TapDetector {
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
        world.removeAll(world.children.query<Bottle>());
        world.removeAll(world.children.query<Straw>());
        world.removeAll(world.children.query<PlasticBag>());
        world.removeAll(world.children.query<TimerComponent>());
        overlays.add(playState.name);
      case PlayState.playing:
        overlays.remove(PlayState.welcome.name);
        overlays.remove(PlayState.gameOver.name);
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
      ..removeAll(world.children.query<SeaTurtle>())
      ..removeAll(world.children.query<Bottle>())
      ..removeAll(world.children.query<Straw>())
      ..removeAll(world.children.query<PlasticBag>());

    playState = PlayState.playing;
    score.value = 0;

    final seaTurtle = SeaTurtle()
      ..position = size / 2 // PlayAreaの中心
      ..anchor = Anchor.center
      ..velocity = Vector2(0, 0); // 初期速度を設定

    world
      // 行動範囲を表示
      ..add(seaTurtle)
      // TODO: 最初はゆっくり追加して、徐々に感覚を狭める
      // 1秒ごとにゴミを追加
      ..add(
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
    score.value += 1;

    switch (rand.nextInt(3)) {
      // 0: bottle, 1: straw, 2: plastic_bag
      case 0:
        final trash = Bottle();
        world.add(trash);

      case 1:
        final trash = Straw();
        world.add(trash);

      default: // case 3:
        final trash = PlasticBag();
        world.add(trash);

        break;
    }
  }

  @override
  void onTap() {
    super.onTap();
    // タップしたらゲームを開始
    startGame();
  }

  @override
  Color backgroundColor() => const Color(0xfff2e8cf);

  SeaTurtle? findSeaTurtle() {
    return world.children.firstWhereOrNull((element) => element is SeaTurtle)
        as SeaTurtle?;
  }
}
