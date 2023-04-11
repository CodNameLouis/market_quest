import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'auth/auth_controller.dart';
import 'auth/auth_page.dart';
import 'constants/app_colors.dart';
import 'routes/app_pages.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Market Quest',
      theme: ThemeData(
        primaryColor: AppColors.secondaryColor,
        scaffoldBackgroundColor: AppColors.secondaryColor,
        dialogBackgroundColor: AppColors.secondaryColor,
        primarySwatch: CustomMaterialColor.titleMaterialColor,
      ),
      getPages: AppPages.pages,
      initialRoute: AuthPage.route,
      initialBinding: BindingsBuilder(() {
        Get.put(AuthController());
      }),
    );
  }
}
