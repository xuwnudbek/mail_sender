import 'package:flutter/material.dart';
import 'package:mail_sender/services/storage_service.dart';
import 'package:mail_sender/ui/pages/home/home_page.dart';
import 'package:mail_sender/ui/pages/send_mails/send_mails_page.dart';

class MainProvider extends ChangeNotifier {
  List<Map<String, dynamic>> menu = [
    {
      "title": "Home",
      "icon": Icons.widgets_rounded,
      "page": HomePage(),
    },
    {
      "title": "Send Mails",
      "icon": Icons.email,
      "page": SendMailsPage(),
    },
  ] as List<Map<String, dynamic>>;

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }

  void logout() {
    StorageService.clear();
  }
}
