import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gmarket/app/routes/app_pages.dart';
import '../controllers/flashscreen_controller.dart';

class FlashscreenView extends GetView<FlashscreenController> {
  @override
  Widget build(BuildContext context) {
    goToGameFlashScreen();
    return Scaffold(
      appBar: AppBar(
        title: Text('Logo'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Logo',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  void goToGameFlashScreen() {
    Future.delayed(Duration(seconds: 2),() =>{
      Get.offNamed(Routes.PETLEAGUE_FLASHSCREEEN)
    });
  }
}
