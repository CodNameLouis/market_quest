import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_quest/auth/auth_controller.dart';

import '../constants/app_colors.dart';
import '../routes/app_routes.dart';
import 'widgets/login_buttom.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  static const route = '/auth';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Image.asset(
              'assets/images/Logo.png',
              scale: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 16.0,
                left: 16.0,
                bottom: 24,
              ),
              child: Column(
                children: [
                  GetBuilder<AuthController>(
                    builder: (control) {
                      return TextFormField(
                        controller: control.email,
                        decoration: InputDecoration(
                          labelText: 'E-mail',
                          hintText: 'Digite seu e-mail',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  GetBuilder<AuthController>(
                    builder: (control) {
                      return TextFormField(
                        controller: control.password,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          hintText: 'Digite sua senha',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        obscureText: true,
                      );
                    },
                  ),
                ],
              ),
            ),
            GetBuilder<AuthController>(
              builder: (control) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: LoginButtom(
                    buttomColor: MaterialStateProperty.all<Color>(
                      AppColors.aceptColor,
                    ),
                    title: 'Entrar',
                    onPressed: () {
                      control.signInWithEmailAndPassword(
                        control.email.text,
                        control.password.text,
                      );
                    },
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GetBuilder<AuthController>(
                  builder: (control) {
                    return LoginButtom(
                      buttomColor: MaterialStateProperty.all<Color>(
                        AppColors.secondaryColor,
                      ),
                      title: 'Entrar com o Google',
                      onPressed: () {
                        control.signupWithGoogle(context);
                      },
                    );
                  },
                ),
                LoginButtom(
                  buttomColor: MaterialStateProperty.all<Color>(
                    AppColors.secondaryColor,
                  ),
                  title: 'Entrar como Convidado',
                  onPressed: () {
                    Get.offNamed(ProductPage.route);
                    Get.snackbar('Atenção', 'Você entrou com um usuário de teste!');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
