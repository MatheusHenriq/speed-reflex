import 'package:flutter_modular/flutter_modular.dart';
import 'package:speed_reflect/modules/game/game_module.dart';
import 'package:speed_reflect/modules/landing/landing_module.dart';

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.module('/', module: LandingModule());
    r.module('/game', module: GameModule());
  }
}
