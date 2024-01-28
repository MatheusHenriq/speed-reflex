import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speed_reflect/modules/game/providers/card_provider.dart';

import '../../../core/constants/app_sounds.dart';
import '../model/card_model.dart';

class GameController {
  final int maxCards = 15;

  final cardListProvider = StateNotifierProvider<CardNotified, List<CardModel>>((
    ref,
  ) {
    return CardNotified();
  });
  final levelProvider = StateProvider<int>((ref) => 1);

  Future createNewGame({required WidgetRef ref}) async {
    ref.read(cardListProvider.notifier).clearAndSetData(cardListData: []);
    int numberOfCardToSelect = Random().nextInt(maxCards - 5) + 3;
    if (ref.watch(levelProvider) < (maxCards - 5)) {
      numberOfCardToSelect = Random().nextInt(ref.watch(levelProvider)) + 3;
    }

    List<int> numberofSelectableIndexes = [];
    ref.read(cardListProvider.notifier).createCardListWithLength(length: maxCards);
    int controlVariable = 0;
    do {
      int randomIndex = Random().nextInt(maxCards);
      if (!numberofSelectableIndexes.contains(randomIndex)) {
        numberofSelectableIndexes.add(randomIndex);
        ref.read(cardListProvider.notifier).updateCard(
            cardList: ref.watch(cardListProvider), cardData: CardModel(isActive: true, isSelected: false), index: randomIndex);
        controlVariable++;
      }
    } while (controlVariable < numberOfCardToSelect);
  }

  bool allSelectableCardsSelected({required WidgetRef ref}) {
    for (var card in ref.watch(cardListProvider)) {
      if (card.isActive == true) {
        return false;
      }
    }
    return true;
  }

  Future<void> clickOnCard({required WidgetRef ref, required CardModel cardModel, required int cardIndex}) async {
    await HapticFeedback.mediumImpact();

    if (cardModel.isSelected == false) {
      ref.read(levelProvider.notifier).state = 1;
      createNewGame(ref: ref);
    }
    ref.read(cardListProvider.notifier).updateCard(
          cardList: ref.watch(cardListProvider),
          cardData: cardModel,
          index: cardIndex,
        );
  }

  Future<void> goToNextLevel({required WidgetRef ref, required ConfettiController confettiController}) async {
    if (allSelectableCardsSelected(ref: ref)) {
      AudioPlayer audioPlayer = AudioPlayer();
      await audioPlayer.play(
        AssetSource(AppSounds.nextLevetClickSound),
      );
      ref.read(levelProvider.notifier).state++;
      if (ref.watch(levelProvider) % 10 == 0) {
        confettiController.play();
      }
      Future.delayed(const Duration(milliseconds: 1500), () {
        confettiController.stop();
      });
      createNewGame(ref: ref);
    }
  }
}
