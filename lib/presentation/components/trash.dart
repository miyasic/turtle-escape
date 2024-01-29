import 'dart:math' as math;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ggc/presentation/components/play_area.dart';
import 'package:ggc/presentation/sample/sample_game.dart';

class Trash extends CircleComponent
    with CollisionCallbacks, HasGameReference<SampleGame> {
  Trash()
      : super(
          radius: 4,
          paint: Paint()..color = Colors.white,
          position: Vector2(0, 0),
        ) {
    // 衝突判定用のヒットボックスを追加
    add(CircleHitbox());
  }
  // ボールの速度
  Vector2 velocity = Vector2(0, 0);

  @override
  void update(double dt) {
    super.update(dt);
    position = position + velocity * dt;
  }

  @override
  Future<void> onLoad() {
    // TODO: Ballに向かって移動させる

    final rand = math.Random();

    // ボールの初期位置をランダムに設定
    velocity = Vector2(rand.nextDouble() - 0.5 * 35, height * 30);

    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);
    // ここで何かと衝突した時の処理を書く
    if (other is PlayArea) {
      if (intersectionPoints.first.y <= 0) {
        velocity.y = -velocity.y; // 画面上端に衝突したら反射
      } else if (intersectionPoints.first.x <= 0) {
        velocity.x = -velocity.x; // 画面左端に衝突したら反射
      } else if (intersectionPoints.first.x >= game.width) {
        velocity.x = -velocity.x; // 画面右端に衝突したら反射
      } else if (intersectionPoints.first.y >= game.height) {
        velocity.y = -velocity.y; // 画面下端に衝突したら反射
      }
    }

    @override
    void onCollisionEnd(PositionComponent other) {
      // TODO: implement onCollisionEnd
      super.onCollisionEnd(other);
      // ここで何かと衝突が終わった時の処理を書く
    }
  }
}
