import 'package:flutter/material.dart';
import 'package:mail_sender/providers/auth/auth_provider.dart';
import 'package:mail_sender/ui/widgets/custom_input.dart';
import 'package:mail_sender/utils/color/app_colors.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>(
        create: (context) => AuthProvider(),
        builder: (context, snapshot) {
          return Scaffold(
            body: Consumer<AuthProvider>(builder: (context, provider, _) {
              return LayoutBuilder(builder: (context, constraints) {
                return Center(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: 400,
                      minWidth: 350,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 12),
                        Text(
                          "Login",
                          style: TextTheme.of(context).titleLarge,
                        ),
                        SizedBox(height: 16),
                        CustomInput(
                          hint: "Email",
                          controller: provider.emailController,
                        ),
                        SizedBox(height: 4),
                        CustomInput(
                          hint: "Password",
                          controller: provider.passwordController,
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: TextButton(
                            onPressed: () {
                              provider.login(context);
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Login"),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                );
              });
            }),
          );
        });
  }
}
