import 'package:flutter_modular/flutter_modular.dart';
import 'package:speed_reflect/modules/game_module.dart';

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.module('/', module: GameModule());
  }
}
