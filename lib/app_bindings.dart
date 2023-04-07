import 'package:get/get.dart';
import 'package:market_quest/auth/auth_controller.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}
