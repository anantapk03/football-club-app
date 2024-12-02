import 'package:flutter/material.dart';

class LocalizationInheritedWidget extends InheritedWidget {
  final Locale locale;
  final Function(Locale) updateLocale;

  const LocalizationInheritedWidget({
    super.key,
    required this.locale,
    required this.updateLocale,
    required super.child,
  });

  static LocalizationInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<LocalizationInheritedWidget>();
  }

  @override
  bool updateShouldNotify(LocalizationInheritedWidget oldWidget) {
    return locale != oldWidget.locale;
  }
}
