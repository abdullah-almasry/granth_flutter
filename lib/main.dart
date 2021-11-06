import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/models/language_model.dart';
import 'package:granth_flutter/screens/splash_screen.dart';
import 'package:granth_flutter/store/AppStore.dart';
import 'package:granth_flutter/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

import 'app_localizations.dart';
import 'app_theme.dart';
import 'utils/resources/strings.dart';

AppStore appStore = AppStore();

Language language;
List<Language> languages = Language.getLanguages();
AppLocalizations appLocalizations;
int mAdShowCount = 0;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await initialize();
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();

  //MobileAds.instance.initialize();

  if (getBoolAsync(IS_DARK_THEME)) {
    appStore.setDarkMode(true);
  } else {
    appStore.setDarkMode(false);
  }

  appStore.setLanguage(getStringAsync(LANGUAGE, defaultValue: defaultLanguage));
  appStore.setNotification(getBoolAsync(IS_NOTIFICATION_ON, defaultValue: true));

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [AppLocalizations.delegate, GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate],
        localeResolutionCallback: (locale, supportedLocales) => locale,
        locale: Locale(appStore.selectedLanguageCode),
        supportedLocales: Language.languagesLocale(),
        home: SplashScreen(),
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: appStore.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        builder: scrollBehaviour(),
      ),
    );
  }
}
