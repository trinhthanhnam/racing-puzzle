import 'dart:ui';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import '../../petleague/core/PetLeagueTheaterCenter.dart';
import '../../petleague/component/map/GMapPlayGround.dart';
import '../../petleague/component/media/SundayAudio.dart';

class SundayGame extends FlameGame with TapDetector, PanDetector {
  late Function fn;
  late GMapPlayGround playGround;
  late SundayTheaterCenter musicCenter;
  late int current;
  final double refreshRate = 30;
  SundayGame() {
    playGround = GMapPlayGround("Stage Sunday Demo");
    current = DateTime.now().millisecond;
    musicCenter = PetLeagueMusicCenter();
  }
  @override
  void onTapDown(tap) {
    playGround.onTapDown(tap);
  }
  @override
  void onPanUpdate(DragUpdateInfo dragUpdate) {
    playGround.onPanUpdate(dragUpdate);
  }
  @override
  Future<void> onLoad() async {
    // TODO: implement onLoad
    super.onLoad();
    // print("Screen: ${size[0]} : ${size[1]}");
    playGround.updateScreenSize(size[0], size[1]);
  }
  void resize(Size s) {
    playGround.resize(s);
    print("MainGame resize called! x: ${s.width} - y: ${s.height}");
  }
  @override
  void render(Canvas canvas) {
    playGround.render(canvas);
  }
  @override
  void update(double t) {
    musicCenter.keepPlayMusicBackground();
    playGround.update(refreshRate);
  }
}

