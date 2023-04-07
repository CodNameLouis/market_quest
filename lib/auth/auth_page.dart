import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_quest/auth/auth_controller.dart';

import '../constants/app_colors.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  static const route = '/auth';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: GetBuilder<AuthController>(
        builder: (control) {
          return ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(AppColors.primaryColor),
            ),
            child: const Text(
              'Entrar com o Google',
              style: TextStyle(
                color: AppColors.titleColor,
              ),
            ),
            onPressed: () {
              control.signup(context);
            },
          );
        },
      )),
    );
  }
}
