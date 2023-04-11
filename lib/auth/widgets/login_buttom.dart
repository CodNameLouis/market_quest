import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_quest/auth/auth_controller.dart';

import '../../constants/app_colors.dart';

class LoginButtom extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final MaterialStateProperty<Color?>? buttomColor;

  const LoginButtom({
    Key? key,
    required this.title,
    required this.onPressed,
    this.buttomColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (control) {
        return ElevatedButton(
          style: ButtonStyle(
            backgroundColor: buttomColor,
          ),
          onPressed: onPressed,
          child: Text(
            title,
            style: const TextStyle(
              color: AppColors.titleColor,
            ),
          ),
        );
      },
    );
  }
}
