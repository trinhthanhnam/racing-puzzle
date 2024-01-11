import 'dart:ui';
import 'package:flame/events.dart';
import 'package:flame/input.dart';

import 'BaseGameElement.dart';
import 'DemoRun.dart';

class MainScreenGame extends BaseGameLangElement {
  late DemoRun demo;
  MainScreenGame() {
    demo = new DemoRun();
  }
  @override
  void render(Canvas canvas) {
    canvas.save();
    demo.render(canvas);
    canvas.restore();
  }
  @override
  void update(double t) {
    demo.update(t);

  }
  @override
  void resize(Size s) {
    print("MainScreenGame resized! x: ${s.width} - y: ${s.height}");
  }

  void mainScreenTapDown(TapDownInfo tap) {
    demo.demoRunTapDown(tap);
  }

  void updateScreenSize(double phoneWidth, double phoneHeight) {
    screenSize.update(phoneWidth, phoneHeight);
    demo.updateScreenSize(phoneWidth, phoneHeight);
  }
}