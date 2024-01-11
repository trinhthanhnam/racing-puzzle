import 'package:get/get.dart';

import '../controllers/slash_controller.dart';

class SlashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SlashController>(
      () => SlashController(),
    );
  }
}
