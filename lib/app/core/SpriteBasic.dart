import 'dart:math';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'GSpriteLang.dart';
import 'BaseGameElement.dart';

class SpriteBasic extends BaseGameLangElement {
  GSpriteLang? player;
  String? source;
  double x = 0;
  double y = 0;
  double speed = 1;
  SpriteBasic(String src, double flexibleSize) {
    source = src;
    player = GSpriteLang(source!, flexibleSize);
    randomPos();
    // print("Player | X: ${screenSize.screenX} - Y: ${screenSize.screenY} - BlockX: ${screenSize.blockHorizontal} - BlockY: ${screenSize.blockVertical}");
  }
  void randomPos() {
    var r =  Random();
    var posX = r.nextDouble() * screenSize.phoneX;
    var posY = r.nextDouble() * screenSize.phoneY;
    player!.getSprite!.position = Vector2(posX, posY);
    x = posX;
    y = posY;
  }
  void render(Canvas canvas) {
    canvas.save();
    player!.render(canvas);
    canvas.restore();
  }
  void update(double t) {
    var r =  Random();
    x += r.nextInt(5) * screenSize.Move;
    y += -3 + r.nextInt(9) * screenSize.Move;
    checkOutside();
    player!.getSprite!.position = Vector2(x, y);
    // print("Bird move by itself: x: ${x} - y ${y} - size: ${player!.getSprite!.size} - pos: ${player!.getSprite!.position}");
  }
  void moveForward() {
    var r =  Random();
    x += 5 + r.nextInt(10) * speed * screenSize.Move;
    y += 10 + (r.nextInt(10)) * speed * screenSize.Move;
    player!.getSprite!.position = Vector2(x, y);
    // print("Bird move by Tap down: x: ${x} - y ${y} - size: ${player!.getSprite!.size} - pos: ${player!.getSprite!.position}");
  }
  void checkOutside() {
    if((x + player!.getSprite!.width) >= screenSize.screenX) x = 0;
    if( (y + player!.getSprite!.width) >= screenSize.screenY || ( y ) <= 0) y = 10;
  }
  void resize(Size s) {
    print("Player resized! x: ${screenSize.screenX} - y: ${screenSize.screenY}");
  }
  void updateScreenSize(double phoneWidth, double phoneHeight) {
    screenSize.update(phoneWidth, phoneHeight);
    player!.updateScreenSize(phoneWidth, phoneHeight);
  }
}