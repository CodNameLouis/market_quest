import 'package:get/get.dart';

import 'app_routes.dart';


class AppPages {
  const AppPages._();

  static final pages = <GetPage>[
    GetPage(
      name: AuthPage.route,
      page: () => const AuthPage(),
      binding: AuthBindings(),
    ),
    GetPage(
      name: ProductPage.route,
      page: () => const ProductPage(),
      binding: ProductPageBindings(),
    ),
  ];
}
