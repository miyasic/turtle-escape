import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ggc/presentation/sample/play_area.dart';
import 'package:ggc/presentation/sample/sample_game.dart';
import 'package:sensors_plus/sensors_plus.dart';

// CircleComponentを継承してBallクラスを作成
// CollisionCallbacks = 衝突時のコールバックを受け取る
// HasGameReference = ゲームの参照
class Ball extends CircleComponent
    with CollisionCallbacks, HasGameReference<SampleGame> {
  Ball({
    required this.velocity,
    required super.position,
    required double radius,
    required this.difficultyModifier,
  }) : super(
          radius: radius,
          anchor: Anchor.center,
          paint: Paint()
            ..color = const Color(0xff1e6091)
            ..style = PaintingStyle.fill,
          children: [CircleHitbox()],
        ); // 他のコンポーネントと衝突判定を行う

  final Vector2 velocity;
  final double difficultyModifier;
  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;

  @override
  void update(double dt) {
    super.update(dt);
    // 速度を時間で割って、1秒あたりの移動距離を計算
    position += velocity * dt;
  }

  @override
  Future<void> onLoad() {
    _accelerometerSubscription = accelerometerEventStream().listen((event) {
      velocity
        // x軸のデータで横方向（左右）の移動を制御
        ..x = -event.x * 20
        // y軸のデータで縦方向（上下）の移動を制御
        ..y = event.y * 20;
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
    if (other is PlayArea) {
      velocity.y = 0;
      velocity.x = 0;
    }
  }

  // @override // 衝突時のコールバック
  // void onCollisionStart(
  //   Set<Vector2> intersectionPoints,
  //   PositionComponent other,
  // ) {
  //   super.onCollisionStart(intersectionPoints, other);
  //   if (other is PlayArea) {
  //     if (intersectionPoints.first.y <= 0) {
  //       // velocity.y = -velocity.y; // 画面上端に衝突したら反射
  //       velocity.y = 0;
  //     } else if (intersectionPoints.first.x <= 0) {
  //       // velocity.x = -velocity.x; // 画面左端に衝突したら反射
  //       velocity.x = 0;
  //     } else if (intersectionPoints.first.x >= game.width) {
  //       // velocity.x = -velocity.x; // 画面右端に衝突したら反射
  //       velocity.x = 0;
  //     } else if (intersectionPoints.first.y >= game.height) {
  //       // ボールが表示可能なプレイエリアから出た後、ボールをゲーム世界から削除します。
  //       add(
  //         RemoveEffect(
  //           delay: 0.35,
  //           onComplete: () {
  //             game.playState = PlayState.gameOver;
  //           },
  //         ),
  //       );
  //     }
  //   }
  // }
}
