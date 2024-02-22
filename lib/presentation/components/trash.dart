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
        ) {
    // 衝突判定用のヒットボックスを追加
    add(CircleHitbox());
  }
  // ゴミの速度
  Vector2 velocity = Vector2(0, 0);

  @override
  void update(double dt) {
    super.update(dt);
    position = position + velocity * dt;
  }

  @override
  Future<void> onLoad() {
    final rand = math.Random();
    final screenWidth = game.size.x - 10;
    final screenHeight = game.size.y - 10;
    final centerX = screenWidth / 2;
    final centerY = screenHeight / 2;

    // 画面の端からスタートするように位置を設定
    double startX;
    double startY;
    switch (rand.nextInt(4)) {
      // 0: 上, 1: 下, 2: 左, 3: 右
      case 0:
        startX = rand.nextDouble() * screenWidth;
        startY = 0;

      case 1:
        startX = rand.nextDouble() * screenWidth;
        startY = screenHeight;

      case 2:
        startX = 0;
        startY = rand.nextDouble() * screenHeight;

      default: // case 3:
        startX = screenWidth;
        startY = rand.nextDouble() * screenHeight;

        break;
    }
    position = Vector2(startX, startY);

    // game内のFishの位置を取得
    final fish = game.findFishFromMovingRange();
    Vector2 targetVector;
    if (fish != null) {
      // Fishに向かう速度ベクトルを計算
      targetVector = Vector2(
        fish.position.x + 80 - startX, // 80はmovingRangeのx座標
        fish.position.y + 220 - startY, // 220はmovingRangeのy座標
      );
    } else {
      // 中央に向かう速度ベクトルを計算
      targetVector = Vector2(centerX - startX, centerY - startY);
    }

    targetVector.normalize(); // 単位ベクトルにする
    velocity = targetVector * (200 + rand.nextDouble() * 20); // 速さをランダムに設定

    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);
    // ここで何かと衝突した時の処理を書く
    if (other is PlayArea) {
      removeFromParent();
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    // TODO: implement onCollisionEnd
    super.onCollisionEnd(other);
    // ここで何かと衝突が終わった時の処理を書く
  }
}
