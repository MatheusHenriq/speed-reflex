import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speed_reflect/modules/game/controller/game_controller.dart';

import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_sounds.dart';
import '../../../widgets/card_container.dart';

class GameView extends StatefulWidget {
  final GameController controller;
  const GameView({super.key, required this.controller});
  static const route = "/game/";

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  final ConfettiController confettiController = ConfettiController();
  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Consumer(builder: (context, ref, child) {
          return ListTile(
            leading: ElevatedButton(
              onPressed: () => Modular.to.pop(),
              child: const Text(
                "Back",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            title: const Center(
              child: Text(
                "Speed Reflect",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
            ),
            trailing: Text(
              "Level ${ref.watch(widget.controller.levelProvider)}",
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          );
        }),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.asset(
            AppImages.landingBackgroundImageJPEG,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
          ),
          ConfettiWidget(
            blastDirectionality: BlastDirectionality.explosive,
            confettiController: confettiController,
            numberOfParticles: 7,
            emissionFrequency: 0.2,
            gravity: 0.3,
          ),
          Row(
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
                    child: Consumer(builder: (context, ref, child) {
                      return CardContainer(
                        onTap: (newCardData) {
                          if (newCardData.isSelected == false) {
                            ref.read(widget.controller.levelProvider.notifier).state = 1;
                            widget.controller.createNewGame(ref: ref);
                          }
                          ref.read(widget.controller.cardListProvider.notifier).updateCard(
                                cardList: ref.watch(widget.controller.cardListProvider),
                                cardData: newCardData,
                                index: index,
                              );
                        },
                        cardData: ref.watch(widget.controller.cardListProvider)[index],
                      );
                    }),
                  ),
                  itemCount: widget.controller.maxCards,
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(left: 6, bottom: 32),
                      child: Consumer(builder: (context, ref, child) {
                        return MaterialButton(
                          color: widget.controller.allSelectableCardsSelected(ref: ref) ? Colors.green[700] : Colors.grey,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                          onPressed: () async {
                            if (widget.controller.allSelectableCardsSelected(ref: ref)) {
                              AudioPlayer audioPlayer = AudioPlayer();
                              await audioPlayer.play(
                                AssetSource(AppSounds.nextLevetClickSound),
                              );
                              ref.read(widget.controller.levelProvider.notifier).state++;
                              if (ref.watch(widget.controller.levelProvider) % 10 == 0) {
                                confettiController.play();
                              }
                              Future.delayed(const Duration(milliseconds: 1500), () {
                                confettiController.stop();
                              });
                              widget.controller.createNewGame(ref: ref);
                            }
                          },
                          child: const Text(
                            'Next',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
