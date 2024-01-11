import 'package:get/get.dart';

import '../controllers/flashscreen_controller.dart';

class FlashscreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FlashscreenController>(
      () => FlashscreenController(),
    );
  }
}
