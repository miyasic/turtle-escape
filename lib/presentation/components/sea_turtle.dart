import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:ggc/presentation/components/trash/bottle.dart';
import 'package:ggc/presentation/components/trash/plastic_bag.dart';
import 'package:ggc/presentation/components/trash/straw.dart';
import 'package:ggc/presentation/game/turtle_escape.dart';
// import 'package:sensors_plus/sensors_plus.dart';
import 'package:vibration/vibration.dart';

// SpriteComponentを継承してSeaTurtleクラスを作成
// CollisionCallbacks = 衝突時のコールバックを受け取る
// HasGameReference = ゲームの参照
class SeaTurtle extends SpriteComponent
    with CollisionCallbacks, HasGameReference<TurtleEscape> {
  SeaTurtle(this.joystick)
      : super(
          size: Vector2(48, 60),
        ) {
    // 衝突判定用のヒットボックスを追加
    final shape = PolygonHitbox([
      Vector2(24, 0),
      Vector2(48, 30),
      Vector2(36, 60),
      Vector2(12, 60),
      Vector2(0, 30),
    ]);
    add(shape);
  }

  // SeaTurtleの速度
  Vector2 velocity = Vector2(0, 0);

  final JoystickComponent joystick;

  // late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;

  @override
  void update(double dt) {
    super.update(dt);

    // final newPosition = position + velocity * dt;
    // // ゲーム画面の範囲内でSeaTurtleを移動させる
    // position = _ensureWithinGameWindow(newPosition);

    // // 速度ベクトルがゼロでない場合、SeaTurtleの向きを更新
    // if (!velocity.isZero()) {
    //   // atan2関数を使用して速度ベクトルの角度を計算（ラジアン単位）
    //   final angleRadians = atan2(velocity.y, velocity.x);

    //   // SeaTurtleの「正面」が上向き(-90度)にデフォルト設定されている場合、90度を加算して調整
    //   angle = angleRadians + pi / 2; // π/2ラジアンを加えることで90度調整
    // }

    if (joystick.direction != JoystickDirection.idle) {
      final newPosition = (joystick.relativeDelta * 2) + position;

      // ゲーム画面の範囲内でSeaTurtleを移動させる
      position = _ensureWithinGameWindow(newPosition);

      // 速度ベクトルがゼロでない場合、SeaTurtleの向きを更新
      if (!joystick.relativeDelta.isZero()) {
        // atan2関数を使用して速度ベクトルの角度を計算（ラジアン単位）
        final angleRadians =
            atan2(joystick.relativeDelta.y, joystick.relativeDelta.x);

        // SeaTurtleの「正面」が上向き(-90度)にデフォルト設定されている場合、90度を加算して調整
        angle = angleRadians + pi / 2; // π/2ラジアンを加えることで90度調整
      }
    }
  }

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    // _accelerometerSubscription = accelerometerEventStream().listen((event) {
    //   velocity
    //     // x軸のデータで横方向（左右）の移動を制御
    //     ..x = -event.x * 30
    //     // y軸のデータで縦方向（上下）の移動を制御
    //     ..y = event.y * 30;
    // });

    // 画像を読み込む
    final sprite = await Sprite.load('sea_turtle.png');
    this.sprite = sprite;
  }

  @override
  void onRemove() {
    // _accelerometerSubscription.cancel();
    super.onRemove();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Bottle || other is Straw || other is PlasticBag) {
      Vibration.vibrate(duration: 200);
      game.playState = PlayState.gameOver;
      game.world.removeAll(game.world.children.query<SeaTurtle>());
      game.world.removeAll(game.world.children.query<Bottle>());
      game.world.removeAll(game.world.children.query<Straw>());
      game.world.removeAll(game.world.children.query<PlasticBag>());

      game.setScore();
    }
  }

  Vector2 _ensureWithinGameWindow(Vector2 newPosition) {
    final halfWidth = size.x / 2;
    final halfHeight = size.y / 2;
    final minX = halfWidth;
    final maxX = game.width - halfWidth;
    final minY = halfHeight;
    final maxY = game.height - halfHeight;

    // SeaTurtleがゲーム画面の枠外に出ないようにする
    newPosition
      ..x = newPosition.x.clamp(minX, maxX)
      ..y = newPosition.y.clamp(minY, maxY);

    return newPosition;
  }
}
