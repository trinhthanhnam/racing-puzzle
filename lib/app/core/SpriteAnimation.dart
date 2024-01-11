import 'dart:math';
import 'dart:ui';
import 'package:flame/events.dart';
import 'package:flame/input.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gmarket/app/routes/app_pages.dart';
import 'GSpriteLangAnimate.dart';
import 'BaseGameElement.dart';

class SpriteAnimation extends BaseGameLangElement{
  late GSpriteLangAnimate newPlayer;
  bool currentSelected = false;
  int timedSelected = 0;
  bool exitGame = false;
  SpriteAnimation(String source, int frame, double step, double flexibleSize) {
    newPlayer = GSpriteLangAnimate(source, frame, step, flexibleSize);
  }
  void render(Canvas canvas) {
    canvas.save();
    newPlayer.render(canvas);
    canvas.restore();
  }
  void update(double t) {
    randomMove();
    checkOutsite();
    checkExit();
    newPlayer.update(t);
  }
  void randomMove() {
    var r = new Random();
    var i = 2 - r.nextDouble() * 4;
    newPlayer.getSprite!.position.x += i*screenSize.Block;
    newPlayer.getSprite!.position.y += i*screenSize.Block;
  }
  void checkOutsite() {
    if((newPlayer.getSprite!.position.x - newPlayer.getSprite!.width) > screenSize.screenX)
    {
      newPlayer.getSprite!.position.x = screenSize.screenX / 8;
      newPlayer.getSprite!.position.y = screenSize.screenY / 2;
    }
    if((newPlayer.getSprite!.position.x + newPlayer.getSprite!.width) < 10)
    {
      newPlayer.getSprite!.position.x = screenSize.screenX / 8;
      newPlayer.getSprite!.position.y = screenSize.screenY / 2;
    }
    if((newPlayer.getSprite!.position.y + newPlayer.getSprite!.height) > screenSize.screenY ) {
      newPlayer.getSprite!.position.x = screenSize.screenX / 8;
      newPlayer.getSprite!.position.y = screenSize.screenY / 2;
    }
    if((newPlayer.getSprite!.position.y - newPlayer.getSprite!.height) < 10)
    {
      newPlayer.getSprite!.position.x = screenSize.screenX / 8;
      newPlayer.getSprite!.position.y = screenSize.screenY / 2;
    }
  }
  void checkExit() {
    if(currentSelected == true) {
      int t = DateTime.now().second;
      if((t - timedSelected).abs() > 10) {
        exitGame = true;
      }
    }
    if(exitGame == true) {
      Get.offNamed(Routes.DEMO);
    }
  }
  void resize(Size s) {

  }
  void isSelected(TapDownInfo details) {
    var tx = details.eventPosition.global.x;
    var ty = details.eventPosition.global.y;
    var x = newPlayer.getSprite!.position.x;
    var y = newPlayer.getSprite!.position.y;
    var w = newPlayer.getSprite!.width;
    var h = newPlayer.getSprite!.height;
    // print("Tap location: X: ${tx} - Y: ${ty}");
    // print("This object: X: ${x} - Y: ${y} - W: ${w} - H: ${h}");
    if( ((tx > x) && (tx < (x + w))) && ((ty > y) && (ty < (y + h))) ) {
      if(currentSelected == false) {
        print("The big bird is selected! Wait 10s to comback to demo screen or click to the wind for stay");
        currentSelected = true;
        timedSelected = DateTime.now().second;
      }
    }
    else {
      currentSelected = false;
      print("Tap to the wind ?");
    }

  }
  void updateScreenSize(double phoneWidth, double phoneHeight) {
    screenSize.update(phoneWidth, phoneHeight);
    newPlayer.updateScreenSize(phoneWidth, phoneHeight);
  }
}