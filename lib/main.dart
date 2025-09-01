import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:opero/firebase_options.dart';
import 'package:opero/product/init/di/di.dart';
import 'package:opero/product/theme/theme.dart';

import 'product/constant/error_page.dart';
import 'product/init/app_initialization/app_initialization.dart';
import 'product/routes/route_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Error ekranını özelleştirme
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return ErrorScreen(message: details.exceptionAsString());
  };

  await AppInitialization.init();

  await setupLocator();

  runApp(const OperoApp());
}

class OperoApp extends StatelessWidget {
  const OperoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.theme(context);

    return MaterialApp.router(routerConfig: router, theme: theme);
  }
}
