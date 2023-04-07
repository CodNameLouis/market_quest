import 'package:get/get.dart';
import './product_page_controller.dart';

class ProductPageBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(ProductPageController());
    }
}