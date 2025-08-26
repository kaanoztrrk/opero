import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:opero/firebase_options.dart';
import 'package:opero/product/init/di/di.dart';
import 'package:opero/product/theme/theme.dart';

import 'product/routes/route_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase başlat
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // DI setup
  await setupLocator();

  // Uygulamayı çalıştır
  runApp(const OperoApp());
}

class OperoApp extends StatelessWidget {
  const OperoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        // Tek theme fonksiyonu ile light/dark otomatik seçimi
        final theme = AppTheme.theme(context);

        return MaterialApp.router(
          routerConfig: router,
          theme: theme,
          // themeMode artık gerekli değil, theme() içinde context'e göre yönetiliyor
        );
      },
    );
  }
}
