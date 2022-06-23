import 'package:flutter/foundation.dart';

class AppStore {
  static final AppStore _singleton = AppStore._internal();

  factory AppStore() {
    return _singleton;
  }

  AppStore._internal();

  final ValueNotifier<bool> _isLightTheme = ValueNotifier(false);
  ValueListenable<bool> get isLightTheme => _isLightTheme;

  void toggleTheme() {
    _isLightTheme.value = !_isLightTheme.value;
  }
}
