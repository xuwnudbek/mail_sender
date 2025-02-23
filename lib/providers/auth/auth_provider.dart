import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mail_sender/services/storage_service.dart';
import 'package:mail_sender/ui/pages/main/main_page.dart';
import 'package:mail_sender/ui/pages/splash/splash_page.dart';
import 'package:mail_sender/ui/widgets/custom_snackbars.dart';

class AuthProvider extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login(BuildContext context) {
    String email = emailController.text;
    String password = passwordController.text;

    if (!email.isEmail) {
      CustomSnackbars.error(context, 'Email xato kiritilgan!');
      return;
    }

    if (password.length != 19 && !password.isPassword) {
      CustomSnackbars.error(context, 'Noto\'g\'ri parol kiritilgan!');
      return;
    }

    // Add your login logic here
    StorageService.write("email", email);
    StorageService.write("password", password);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const SplashPage(),
      ),
    );
  }
}

extension PasswordExtension on String {
  bool get isPassword {
    // length 19
    // split by space every 4 characters

    if (length != 19) return false;

    List<String> parts = split(' ');
    if (parts.length != 4) return false;

    for (String part in parts) {
      if (part.length != 4) return false;
    }

    return true;
  }
}
