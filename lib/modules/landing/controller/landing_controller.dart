import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speed_reflect/modules/game/controller/game_controller.dart';

import '../../game/view/game_view.dart';

class LandingController {
  void goToGamePage({required WidgetRef ref}) {
    Modular.get<GameController>().createNewGame(ref: ref);
    Modular.to.pushNamed(GameView.route);
  }
}
