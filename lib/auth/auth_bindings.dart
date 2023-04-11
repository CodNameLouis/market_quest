import 'package:get/get.dart';

import 'auth_controller.dart';

class AuthBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}
