import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ggc/presentation/sample/moving_range.dart';
import 'package:ggc/presentation/sample/sample_game.dart';
import 'package:sensors_plus/sensors_plus.dart';

// CircleComponentを継承してBallクラスを作成
// CollisionCallbacks = 衝突時のコールバックを受け取る
// HasGameReference = ゲームの参照
class Ball extends CircleComponent
    with CollisionCallbacks, HasGameReference<SampleGame> {
  Ball() : super(radius: 10, paint: Paint()..color = Colors.white) {
    // 衝突判定用のヒットボックスを追加
    add(CircleHitbox());
  }
  // ボールの速度
  Vector2 velocity = Vector2(0, 0);

  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;

  @override
  void update(double dt) {
    super.update(dt);
    // 速度を時間で割って、1秒あたりの移動距離を計算
    // position += velocity * dt;
    // final newPosition = position + velocity * dt;

    // if (!isCollided) {
    final newPosition = position + velocity * dt;
    // MovingRangeの範囲内でボールを移動させる
    position = _ensureWithinMovingRange(newPosition);
    // }
  }

  @override
  Future<void> onLoad() {
    _accelerometerSubscription = accelerometerEventStream().listen((event) {
      // if (velocity != Vector2.zero()) {
      velocity
        // x軸のデータで横方向（左右）の移動を制御
        ..x = -event.x * 30
        // y軸のデータで縦方向（上下）の移動を制御
        ..y = event.y * 30;
      // }
    });

    return super.onLoad();
  }

  @override
  void onRemove() {
    _accelerometerSubscription.cancel();
    super.onRemove();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);
    // ここで何かと衝突した時の処理を書く
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    // TODO: implement onCollisionEnd
    super.onCollisionEnd(other);
    // ここで何かと衝突が終わった時の処理を書く
  }

  Vector2 _ensureWithinMovingRange(Vector2 newPosition) {
    final movingRange = parent! as MovingRange; // MovingRangeコンポーネントを取得
    final rangeRadius = movingRange.radius;
    final rangeCenter = Vector2(rangeRadius, rangeRadius);

    // MovingRangeの中心からのボールの新しい位置までの距離を計算
    final distanceFromCenter = newPosition.distanceTo(rangeCenter);

    // ボールがMovingRangeの範囲外に出る場合は、範囲内に収まるように位置を調整
    if (distanceFromCenter + radius > rangeRadius) {
      // MovingRangeの境界上にボールを位置させるための方向ベクトルを計算
      final direction = newPosition - rangeCenter
        ..normalize(); // 方向ベクトルを正規化
      // MovingRangeの境界上にボールを位置させる
      return rangeCenter + direction * (rangeRadius - radius);
    }

    // ボールがMovingRangeの範囲内にある場合は、新しい位置をそのまま使用
    return newPosition;
  }
}
