import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:ggc/presentation/components/moving_range.dart';
import 'package:ggc/presentation/components/trash.dart';
import 'package:ggc/presentation/sample/sample_game.dart';
import 'package:sensors_plus/sensors_plus.dart';

// SpriteComponentを継承してSeaTurtleクラスを作成
// CollisionCallbacks = 衝突時のコールバックを受け取る
// HasGameReference = ゲームの参照
class SeaTurtle extends SpriteComponent
    with CollisionCallbacks, HasGameReference<SampleGame> {
  SeaTurtle()
      : super(
          size: Vector2(40, 50),
        ) {
    // 衝突判定用のヒットボックスを追加
    final shape = PolygonHitbox([
      Vector2(20, 0),
      Vector2(40, 10),
      Vector2(30, 50),
      Vector2(10, 50),
      Vector2(0, 10),
    ]);
    add(shape);
  }

  // Fishの速度
  Vector2 velocity = Vector2(0, 0);

  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;

  @override
  void update(double dt) {
    super.update(dt);

    final newPosition = position + velocity * dt;
    // MovingRangeの範囲内でFishを移動させる
    position = _ensureWithinMovingRange(newPosition);

    // 速度ベクトルがゼロでない場合、Fishの向きを更新
    if (!velocity.isZero()) {
      // atan2関数を使用して速度ベクトルの角度を計算（ラジアン単位）
      final angleRadians = atan2(velocity.y, velocity.x);

      // Fishの「正面」が上向き(-90度)にデフォルト設定されている場合、90度を加算して調整
      angle = angleRadians + pi / 2; // π/2ラジアンを加えることで90度調整
    }
  }

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    _accelerometerSubscription = accelerometerEventStream().listen((event) {
      velocity
        // x軸のデータで横方向（左右）の移動を制御
        ..x = -event.x * 30
        // y軸のデータで縦方向（上下）の移動を制御
        ..y = event.y * 30;
    });
    // 画像を読み込む
    final sprite = await Sprite.load('sea_turtle.png');
    this.sprite = sprite;
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
    if (other is Trash) {
      game.playState = PlayState.gameOver;
      game.world.removeAll(game.world.children.query<MovingRange>());
      game.world.removeAll(game.world.children.query<Trash>());
    }
  }

  Vector2 _ensureWithinMovingRange(Vector2 newPosition) {
    final movingRange = parent! as MovingRange; // MovingRangeコンポーネントを取得
    final rangeRadius = movingRange.radius;
    final rangeCenter = Vector2(rangeRadius, rangeRadius);

    // MovingRangeの中心からのFishの新しい位置までの距離を計算
    final distanceFromCenter = newPosition.distanceTo(rangeCenter);

    // FishがMovingRangeの範囲外に出る場合は、範囲内に収まるように位置を調整
    if (distanceFromCenter + 5 > rangeRadius) {
      // MovingRangeの境界上にFishを位置させるための方向ベクトルを計算
      final direction = newPosition - rangeCenter
        ..normalize(); // 方向ベクトルを正規化
      // MovingRangeの境界上にFishを位置させる
      return rangeCenter + direction * (rangeRadius - 5);
    }

    // FishがMovingRangeの範囲内にある場合は、新しい位置をそのまま使用
    return newPosition;
  }
}
