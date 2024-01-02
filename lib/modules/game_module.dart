// ignore_for_file: avoid_renaming_method_parameters

import 'package:flutter_modular/flutter_modular.dart';
import 'package:speed_reflect/modules/game/controller/game_controller.dart';
import 'package:speed_reflect/modules/game/view/game_view.dart';

class GameModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(GameController.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => GameView(
        controller: Modular.get<GameController>(),
      ),
    );
  }
}
