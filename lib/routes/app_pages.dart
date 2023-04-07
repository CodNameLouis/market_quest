import 'package:get/get.dart';

import '../auth/auth_bindings.dart';
import '../auth/auth_page.dart';
import '../product_page/product_page.dart';
import '../product_page/product_page_bindings.dart';

class AppPages {
  const AppPages._();

  static final pages = <GetPage>[
    GetPage(
      name: AuthPage.route,
      page: () => AuthPage(),
      binding: AuthBindings(),
    ),
    GetPage(
      name: ProductPage.route,
      page: () => ProductPage(),
      binding: ProductPageBindings(),
    ),
  ];
}
