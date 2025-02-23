import 'package:flutter/material.dart';
import 'package:mail_sender/providers/home/home_provider.dart';
import 'package:mail_sender/utils/color/app_colors.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, _) {
        return Container(
          width: double.infinity,
          // margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
          ),
          padding: EdgeInsets.all(24),
          child: Center(
            child: Text("Home Page"),
          ),
        );
      },
    );
  }
}
