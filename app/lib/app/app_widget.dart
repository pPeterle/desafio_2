import 'package:app/app/app_store.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  AppWidget({super.key});

  AppStore store = AppStore();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: store.isLightTheme,
      builder: (context, isLightTheme, child) {
        return MaterialApp.router(
          title: 'Flutter Slidy',
          theme: isLightTheme ? lightTheme : darkTheme,
          routeInformationParser: Modular.routeInformationParser,
          routerDelegate: Modular.routerDelegate,
        );
      },
    );
  }
}
