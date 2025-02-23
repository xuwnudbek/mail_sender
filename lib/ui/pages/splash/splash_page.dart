import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mail_sender/services/storage_service.dart';
import 'package:mail_sender/ui/pages/auth/auth_page.dart';
import 'package:mail_sender/ui/pages/main/main_page.dart';
import 'package:mail_sender/utils/color/app_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void checkAuth() {
    String email = StorageService.read("email") ?? "";
    String password = StorageService.read("password") ?? "";

    inspect(email);
    inspect(password);

    if (email.isNotEmpty && password.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const MainPage(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const AuthPage(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      checkAuth();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              height: 150,
              child: Image.asset("assets/images/gmail.png"),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: 150,
              child: LinearProgressIndicator(
                backgroundColor: AppColors.black.withValues(alpha: 0.1),
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            )
          ],
        ),
      ),
    );
  }
}
