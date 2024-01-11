import 'dart:ui';
import 'package:flame/components.dart';

class BaseGameElement {
  void render(Canvas canvas) {}
  void update(double t) {}
  void resize(Size s) {}
  void syncPosition(Vector2 v) {}
}

class BaseGameLangElement extends BaseGameElement {
  Vector2 position = Vector2(0,0);
  void updateScreenSize(double phoneWidth, double phoneHeight) {
    screenSize.update(phoneWidth, phoneHeight);
  }
  ConfigLang screenSize = ConfigLang();
}

class BaseGamePortElement extends BaseGameElement {
  Vector2 position = Vector2(0,0);
  void updateScreenSize(double phoneWidth, double phoneHeight) {
    screenSize.update(phoneWidth, phoneHeight);
  }
  ConfigPort screenSize = ConfigPort();
}

abstract class Config {
  void update(double phoneWidth, double phoneHeight);
  double getFlexWidth(double w);
  double getFlexHeight(double h);
}

class ConfigLang extends Config {
  double SCREEN_WIDTH = 1600;
  double SCREEN_HEIGHT = 900;
  double phoneX = 0;
  double phoneY = 0;
  double screenX = 0;
  double screenY = 0;
  double blockHorizontal = 0;
  double blockVertical = 0;
  double scaleXRatio = 1;
  double scaleYRatio = 1;
  double Block = 0;
  double posX = 0;
  double posY = 0;
  double Move = 1;
  ConfigLang() {
    double a = window.physicalSize.width.roundToDouble();
    double b = window.physicalSize.height.roundToDouble();
    // double a = 3200;
    // double b = 1800;
    if(a > b)
    {
      phoneX = a;
      phoneY = b;
    }
    else
    {
      phoneX = b;
      phoneY = a;
    }
    screenX = phoneX;
    screenY = phoneY;
    blockHorizontal = ((screenX / SCREEN_WIDTH)*100).round()/100;
    blockVertical = ((screenY / SCREEN_HEIGHT)*100).round()/100;
    Block = blockVertical;
    scaleXRatio = screenX / blockHorizontal;
    scaleYRatio = screenY / blockVertical;
    posX = 0;
    posY = 0;
    Move *= Block;
  }
  update(double phoneWidth, double phoneHeight) {
    double a = phoneWidth;
    double b = phoneHeight;
    if(a > b)
    {
      // if(a == phoneX && b == phoneY) return;
      phoneX = a;
      phoneY = b;
    }
    else
    {
      // if(b == phoneX && a == phoneY) return;
      phoneX = b;
      phoneY = a;
    }
    screenX = phoneX;
    screenY = phoneY;
    blockHorizontal = ((screenX / SCREEN_WIDTH)*100).round()/100;
    blockVertical = ((screenY / SCREEN_HEIGHT)*100).round()/100;
    Block = blockVertical;
    // Block = ( ((blockHorizontal + blockVertical) / 2 )*100).round()/100;
    scaleXRatio = screenX / blockHorizontal;
    scaleYRatio = screenY / blockVertical;
    posX = 0;
    Move *= Block;
    // print("Updated config: ScreenX: ${screenX} ScreenY: ${screenY} Block: ${Block} Move: ${Move}");
  }
  double getFlexWidth(double w) {
    return (w * Block).roundToDouble();
  }
  double getFlexHeight(double h) {
    return (h * Block).roundToDouble();
  }
}

class ConfigPort extends Config {
  double SCREEN_WIDTH = 900;
  double SCREEN_HEIGHT = 1600;
  double HEAD_HEIGHT = 200;
  double CENTER_HEIGHT = 1100;
  double FOOT_HEIGHT = 300;
  double NOFITFY_HEIGHT = 500;
  double phoneX = 0;
  double phoneY = 0;
  double screenX = 0;
  double screenY = 0;
  double blockHorizontal = 0;
  double blockVertical = 0;
  double scaleXRatio = 1;
  double scaleYRatio = 1;
  double Block = 0;
  double posX = 0;
  double posY = 0;
  double Move = 1;
  ConfigPort() {
    double a = window.physicalSize.width;
    double b = window.physicalSize.height;
    // double a = 3200;
    // double b = 1800;
    if(a < b)
    {
      if(a == phoneX && b == phoneY) return;
      phoneX = a;
      phoneY = b;
    }
    else
    {
      if(b == phoneX && a == phoneY) return;
      phoneX = b;
      phoneY = a;
    }
    screenX = phoneX;
    screenY = phoneY;
    blockHorizontal = ((screenX / SCREEN_WIDTH)*100).round()/100;
    blockVertical = ((screenY / SCREEN_HEIGHT)*100).round()/100;
    Block = blockHorizontal;
    scaleXRatio = screenX / blockHorizontal;
    scaleYRatio = screenY / blockVertical;
    posX = 0;
    posY = 0;
    Move *= Block;
  }
  update(double phoneWidth, double phoneHeight) {
    double a = phoneWidth;
    double b = phoneHeight;
    if(a < b)
    {
      phoneX = a;
      phoneY = b;
    }
    else
    {
      phoneX = b;
      phoneY = a;
    }
    screenX = phoneX;
    screenY = phoneY;
    blockHorizontal = ((screenX / SCREEN_WIDTH)*100).round()/100;
    blockVertical = ((screenY / SCREEN_HEIGHT)*100).round()/100;
    Block = blockHorizontal;
    // Block = ( (blockHorizontal + blockVertical) / 2 ).roundToDouble();
    scaleXRatio = screenX / blockHorizontal;
    scaleYRatio = screenY / blockVertical;
    posX = 0;
    Move *= Block;
    // print("Updated config: ScreenX: ${screenX} ScreenY: ${screenY} Block: ${Block} Move: ${Move}");
  }
  double getFlexWidth(double w) {
    return (w * Block).roundToDouble();
  }
  double getFlexHeight(double h) {
    return (h * Block).roundToDouble();
  }
}