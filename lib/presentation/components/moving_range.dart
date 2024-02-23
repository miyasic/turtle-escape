// ゲーム画面の枠
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ggc/presentation/components/sea_turtle.dart';
import 'package:ggc/presentation/sample/sample_game.dart';

class MovingRange extends CircleComponent with HasGameReference<SampleGame> {
  MovingRange()
      : super(
          radius: 120,
          paint: Paint()..color = Colors.transparent,
          children: [CircleHitbox()], // 他のコンポーネントと衝突判定を行う
          anchor: Anchor.center,
          position: Vector2(0, 0),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    position = game.size / 2;
    final seaTurtle = SeaTurtle()
      ..position = size / 2 // PlayAreaの中心
      ..anchor = Anchor.center
      ..velocity = Vector2(0, 0); // 初期速度を設定
    add(seaTurtle);
  }

  SeaTurtle? findSeaTurtle() {
    return firstChild<SeaTurtle>();
  }
}
