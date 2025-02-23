import 'package:flutter/material.dart';
import 'package:mail_sender/providers/home/home_provider.dart';
import 'package:mail_sender/providers/main/main_provider.dart';
import 'package:mail_sender/providers/send_mails/send_mails_provider.dart';

import 'package:mail_sender/utils/color/app_colors.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => SendMailsProvider()),
      ],
      builder: (context, snapshot) {
        return Scaffold(
          body: Consumer2<MainProvider, HomeProvider>(builder: (context, mainProvider, homeProvider, _) {
            return Column(
              children: [
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.05),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Mail Sender",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.logout_rounded),
                          onPressed: () {
                            mainProvider.logout();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 300,
                        padding: EdgeInsets.only(right: 16),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 48),
                              ...mainProvider.menu.map((e) {
                                bool isSelected = mainProvider.menu.indexOf(e) == mainProvider.selectedIndex;
                                return ListTile(
                                  leading: Icon(
                                    e["icon"],
                                  ),
                                  title: Text(
                                    e["title"],
                                    style: TextStyle(
                                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                    ),
                                  ),
                                  iconColor: isSelected ? AppColors.primary : AppColors.black.withValues(alpha: 0.6),
                                  textColor: isSelected ? AppColors.primary : AppColors.black.withValues(alpha: 0.6),
                                  selectedColor: AppColors.primary,
                                  selectedTileColor: AppColors.primary.withValues(alpha: 0.2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(25),
                                      left: Radius.circular(0),
                                    ),
                                  ),
                                  onTap: () {
                                    mainProvider.selectedIndex = mainProvider.menu.indexOf(e);
                                  },
                                  selected: isSelected,
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: mainProvider.menu[mainProvider.selectedIndex]["page"],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        );
      },
    );
  }
}
