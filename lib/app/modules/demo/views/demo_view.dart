import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../app/routes/app_pages.dart';
import '../controllers/demo_controller.dart';
import 'package:flame/flame.dart';

class DemoView extends GetView<DemoController> {
  final double spacing = 15;
  @override
  Widget build(BuildContext context) {
    loading();
    return Scaffold(
      appBar: AppBar(
        title: Text('App listing for demo'),
        backgroundColor: Colors.black12,
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          children: [
            SizedBox(height: spacing),
            ElevatedButton(onPressed: (){
              Get.offNamed(Routes.SLASH);
            }, child: Text("Start Slash Game "),),
            SizedBox(height: spacing),
            ElevatedButton(onPressed: (){
              Get.offNamed(Routes.SNAKE_LOBBY);
            }, child: Text("Start Snake Game "),),
            SizedBox(height: spacing),
            ElevatedButton(onPressed: (){
              Get.offNamed(Routes.PETLEAGUE_LOBBYSCREEN);
            }, child: Text("Start Pet League Legend"),),
            SizedBox(height: spacing),
            ElevatedButton(onPressed: (){
              Get.offNamed(Routes.SATURDAY);
            }, child: Text("Start Saturday With Running"),),
            SizedBox(height: spacing),
            ElevatedButton(onPressed: (){
              Get.offNamed(Routes.SUNDAY);
            }, child: Text("Start Sunday With Connecting"),),
          ],
        )
      )
      );
  }
  Future<void> loading() async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }
}
