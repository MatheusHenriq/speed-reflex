import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speed_reflect/app_modules.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      child: ModularApp(
        module: AppModule(),
        child: MaterialApp.router(
          title: 'Speed Reflect',
          routerConfig: Modular.routerConfig,
        ),
      ),
    ),
  );
}
