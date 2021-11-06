import 'package:flutter/material.dart';
import 'package:granth_flutter/app_localizations.dart';
import 'package:granth_flutter/utils/constants.dart';
import 'package:granth_flutter/utils/resources/colors.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';

part 'AppStore.g.dart';

class AppStore = AppStoreBase with _$AppStore;

abstract class AppStoreBase with Store {
  @observable
  bool isDarkMode = false;

  @observable
  String selectedLanguageCode = defaultLanguage;

  @observable
  bool isNotificationOn = true;

  @action
  Future<void> setDarkMode(bool aIsDarkMode) async {
    isDarkMode = aIsDarkMode;

    if (isDarkMode) {
      setStatusBarColor(app_background_black);
    } else {
      setStatusBarColor(app_background);
    }
  }

  @action
  Future<void> setLanguage(String aSelectedLanguageCode, {BuildContext context}) async {
    selectedLanguageCode = aSelectedLanguageCode;

    language = languages.firstWhere((element) => element.languageCode == aSelectedLanguageCode);
    await setValue(LANGUAGE, aSelectedLanguageCode);

    if (context != null) {
      appLocalizations = AppLocalizations.of(context);
      errorThisFieldRequired = appLocalizations.translate('field_Required');
    }
  }

  @action
  void setNotification(bool val) {
    isNotificationOn = val;

    setValue(IS_NOTIFICATION_ON, val);

    if (isMobile) {
      
    }
  }
}
