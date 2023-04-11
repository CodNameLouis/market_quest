import 'package:get/get.dart';

import 'auth/auth_controller.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}
