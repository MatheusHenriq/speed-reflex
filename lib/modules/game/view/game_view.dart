import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speed_reflect/modules/controller/game_controller.dart';

import '../../../widgets/card_container.dart';
import '../model/card_model.dart';

class GameView extends ConsumerWidget {
  final GameController controller;
  const GameView({super.key, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    controller.createRandomCard(ref: ref);
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
            child: Center(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 24,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) => UnconstrainedBox(
                  child: CardContainer(
                    onPressed: () {},
                    cardData: ref.watch(controller.cardListProvider)[index],
                  ),
                ),
                itemCount: controller.maxCards,
              ),
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
                    color: !ref.watch(controller.cardListProvider).contains(CardModel(isActive: true, isSelected: true))
                        ? Colors.green
                        : Colors.grey,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    onPressed: () => controller.createRandomCard(ref: ref),
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
