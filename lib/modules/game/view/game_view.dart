import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speed_reflect/modules/game/controller/game_controller.dart';

import '../../../widgets/card_container.dart';

class GameView extends ConsumerWidget {
  final GameController controller;
  const GameView({super.key, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Speed Reflect"),
      ),
      body: Row(
        children: [
          const Spacer(
            flex: 1,
          ),
          Flexible(
            flex: 6,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 24,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) => UnconstrainedBox(
                child: CardContainer(
                  onTap: (p0) {
                    ref.read(controller.cardListProvider.notifier).updateCard(
                          cardList: ref.watch(controller.cardListProvider),
                          cardData: p0,
                          index: index,
                        );
                  },
                  cardData: ref.watch(controller.cardListProvider)[index],
                ),
              ),
              itemCount: controller.maxCards,
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 6, bottom: 12),
                  child: MaterialButton(
                    color: Colors.grey,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    onPressed: () => controller.createNewGame(ref: ref),
                    child: const Text('Next'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
