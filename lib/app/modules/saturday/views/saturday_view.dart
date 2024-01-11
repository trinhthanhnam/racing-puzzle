import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import '../controllers/saturday_controller.dart';
import 'SaturdayGame.dart';

class SaturdayView extends GetView<SaturdayController> {
  @override
  Widget build(BuildContext context) {
    loading();
    return GameWidget(
        game: SaturdayGame(),
    );
  }
  Future<void> loading() async {
    if (!kIsWeb) {
      await Flame.device.setOrientation(DeviceOrientation.landscapeLeft);
      await Flame.device.fullScreen();
    }
  }
}
