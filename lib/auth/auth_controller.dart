import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../product_page/product_page.dart';

class AuthController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signupWithGoogle(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      await auth.signInWithCredential(authCredential);

      Get.offNamed(ProductPage.route);
    }
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar('Sucesso', 'Login efetuado com sucesso!');
      Get.offNamed(ProductPage.route);
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Erro', 'Por favor, digite usuário e senha!');
      if (e.code == 'user-not-found') {
        Get.snackbar('Erro', 'Usuário não encontrado com o email informado.');
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Erro', 'Senha incorreta.');
      }
    }
  }
}
