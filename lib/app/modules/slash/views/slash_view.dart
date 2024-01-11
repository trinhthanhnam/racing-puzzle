import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/slash_controller.dart';

class SlashView extends GetView<SlashController> {
  // var theController = Get.find<SlashController>(tag: 'SlashController');
  @override
  Widget build(BuildContext context) {
    Flame.device.setPortrait();
    print("Slash Game Starting ...");
    return controller.displayGame(context);
  }
}
