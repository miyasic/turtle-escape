// ゲーム画面の枠
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ggc/presentation/components/fish.dart';
import 'package:ggc/presentation/sample/sample_game.dart';

class MovingRange extends CircleComponent with HasGameReference<SampleGame> {
  MovingRange()
      : super(
          radius: 100,
          paint: Paint()..color = const Color.fromARGB(255, 47, 42, 142),
          children: [CircleHitbox()], // 他のコンポーネントと衝突判定を行う
          anchor: Anchor.center,
          position: Vector2(0, 0),
        );

  @override
  Future<void> onLoad() async {
    // TODO: implement onLoad
    await super.onLoad();
    position = game.size / 2;
    final fish = Fish()
      ..position = size / 2 // PlayAreaの中心
      ..anchor = Anchor.center
      ..velocity = Vector2(0, 0); // 初期速度を設定
    add(fish);
  }

  Fish? findFish() {
    return firstChild<Fish>();
  }
}
