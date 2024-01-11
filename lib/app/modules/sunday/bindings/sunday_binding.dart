import 'package:get/get.dart';

import '../controllers/sunday_controller.dart';

class SundayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SundayController>(
      () => SundayController(),
    );
  }
}
