import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../views/SundayGame.dart';
import '../controllers/sunday_controller.dart';


class SundayView extends GetView<SundayController> with WidgetsBindingObserver{
  @override
  Widget build(BuildContext context) {
    loading();
    return GameWidget(
      game: SundayGame(),
    );
  }
  Future<void> loading() async {
    if (!kIsWeb) {
      await Flame.device.setOrientation(DeviceOrientation.portraitUp);
      await Flame.device.fullScreen();
    }
  }
}
