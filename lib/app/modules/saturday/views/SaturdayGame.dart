import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import '../../../core/MainScreen.dart';

class SaturdayGame extends FlameGame with DoubleTapDetector, TapDetector {
  late Function fn;
  late MainScreenGame mainScreen;
  final double RefreshRate = 30;
  SaturdayGame() {
    fn = init;
    mainScreen = MainScreenGame();
  }
  @override
  void onTapDown(details) {
    mainScreen.mainScreenTapDown(details);
    // print("onTapDown event");
  }
  @override
  void onDoubleTap() {
    print("onDoubleTap event");
  }
  @override
  Future<void> onLoad() async {
    // TODO: implement onLoad
    super.onLoad();
    mainScreen.updateScreenSize(size[0], size[1]);
  }
  @override
  void resize(Size s) {
    mainScreen.resize(s);
    print("MainGame resize called! x: ${s.width} - y: ${s.height}");
  }
  @override
  void render(Canvas canvas) {
    mainScreen.render(canvas);
  }
  @override
  void update(double t) {
    fn();
    mainScreen.update(RefreshRate);
  }
  void init() {
    fn = refresh;
  }
  void refresh() {
    mainScreen.update(0);
  }
}

