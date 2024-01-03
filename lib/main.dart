import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speed_reflect/app_modules.dart';

import 'core/styles/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
  ]);
  runApp(
    ProviderScope(
      child: ModularApp(
        module: AppModule(),
        child: MaterialApp.router(
          theme: AppTheme.lightTheme,
          title: 'Speed Reflex',
          routerConfig: Modular.routerConfig,
        ),
      ),
    ),
  );
}
