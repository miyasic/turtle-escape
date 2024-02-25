import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ggc/presentation/game/turtle_escape.dart';

// ゲーム画面の枠
class PlayArea extends RectangleComponent with HasGameReference<TurtleEscape> {
  PlayArea()
      : super(
          paint: Paint()..color = const Color(0xfff2e8cf),
          children: [RectangleHitbox()], // 他のコンポーネントと衝突判定を行う
        );

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    size = Vector2(game.width, game.height);

    final sprite = await game.loadSprite(
      'sea_background.jpg',
    );
    // 画像のアスペクト比を計算
    final aspectRatio = sprite.image.width / sprite.image.height;

    // 画面のサイズに基づいて、カバーフィットで表示するためのサイズを計算
    Vector2 spriteSize;
    if (game.size.x / game.size.y > aspectRatio) {
      spriteSize = Vector2(game.size.x, game.size.x / aspectRatio);
    } else {
      spriteSize = Vector2(game.size.y * aspectRatio, game.size.y);
    }

    // SpriteComponentを作成して、計算したサイズを設定
    final spriteComponent = SpriteComponent(sprite: sprite, size: spriteSize)
      ..position = Vector2(
        (game.size.x - spriteSize.x) / 2,
        (game.size.y - spriteSize.y) / 2,
      ); // 画像を中央に配置

    // SpriteComponentをPlayAreaに追加
    add(spriteComponent);
  }
}
