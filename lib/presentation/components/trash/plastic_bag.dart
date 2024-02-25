import 'dart:math' as math;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:ggc/presentation/components/play_area.dart';
import 'package:ggc/presentation/game/turtle_escape.dart';

class PlasticBag extends SpriteComponent
    with CollisionCallbacks, HasGameReference<TurtleEscape> {
  PlasticBag()
      : super(
          size: Vector2(23, 33),
        ) {
    // 衝突判定用のヒットボックスを追加
    final shape = PolygonHitbox([
      Vector2(11, 0),
      Vector2(13, 9),
      Vector2(20, 3),
      Vector2(23, 9),
      Vector2(20, 33),
      Vector2(0, 28),
    ]);
    add(shape);

    final rand = math.Random();
    rotationSpeed = rand.nextDouble() * 180 - 90;
  }
  // ゴミの速度
  Vector2 velocity = Vector2(0, 0);

  // ゴミの回転速度（度/秒）
  late double rotationSpeed;

  @override
  void update(double dt) {
    super.update(dt);
    position = position + velocity * dt;

    angle += rotationSpeed * dt * math.pi / 180;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // 画像を読み込む
    final sprite = await Sprite.load('plastic_bag.png');
    this.sprite = sprite;

    final rand = math.Random();
    final screenWidth = game.size.x - 33;
    final screenHeight = game.size.y - 33;
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

    // game内のSeaTurtleの位置を取得
    final seaTurtle = game.findSeaTurtle();
    Vector2 targetVector;
    if (seaTurtle != null) {
      // SeaTurtleに向かう速度ベクトルを計算
      targetVector = Vector2(
        seaTurtle.position.x - startX,
        seaTurtle.position.y - startY,
      );
    } else {
      // 中央に向かう速度ベクトルを計算
      targetVector = Vector2(centerX - startX, centerY - startY);
    }

    targetVector.normalize(); // 単位ベクトルにする
    velocity = targetVector * (200 + rand.nextDouble() * 20); // 速さをランダムに設定
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
