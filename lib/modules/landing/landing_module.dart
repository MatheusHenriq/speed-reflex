// ignore_for_file: avoid_renaming_method_parameters

import 'package:flutter_modular/flutter_modular.dart';
import 'package:speed_reflect/modules/game/controller/game_controller.dart';

import 'controller/landing_controller.dart';
import 'view/landing_view.dart';

class LandingModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(LandingController.new);
    i.addSingleton(GameController.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => LandingView(
        controller: Modular.get<LandingController>(),
      ),
    );
  }
}
