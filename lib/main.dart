import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mail_sender/providers/main/main_provider.dart';
import 'package:mail_sender/ui/pages/splash/splash_page.dart';
import 'package:mail_sender/utils/theme/app_themes.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  await GetStorage.init("mail_sender");

  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1200, 700),
    center: true,
    title: "Mail Sender",
    backgroundColor: Colors.white,
    skipTaskbar: false,
    windowButtonVisibility: true,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.maximize();
  });

  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainProvider>(
      create: (context) => MainProvider(),
      builder: (context, snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            FlutterQuillLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
          ],
          theme: AppThemes.themeData,
          home: SplashPage(),
        );
      },
    );
  }
}
