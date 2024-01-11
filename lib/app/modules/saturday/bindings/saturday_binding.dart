import 'package:get/get.dart';

import '../controllers/saturday_controller.dart';

class SaturdayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SaturdayController>(
      () => SaturdayController(),
    );
  }
}
