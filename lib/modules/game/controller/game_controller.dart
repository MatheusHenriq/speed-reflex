import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speed_reflect/modules/game/providers/card_provider.dart';
import '../model/card_model.dart';

class GameController {
  final int _maxCards = 15;
  final int _baseLevelToShowconfetti = 10;
  final int _defaultNumberOfClickableCards = 3;
  final int _numberToControlCardGrow = 5;

  final cardListProvider = StateNotifierProvider<CardNotified, List<CardModel>>((
    ref,
  ) {
    return CardNotified();
  });
  final levelProvider = StateProvider<int>((ref) => 1);

  Future createNewGame({required WidgetRef ref}) async {
    ref.read(cardListProvider.notifier).clearAndSetData(cardListData: []);
    int numberOfCardToSelect = Random().nextInt(_maxCards - _numberToControlCardGrow) + _defaultNumberOfClickableCards;
    if (ref.watch(levelProvider) < (_maxCards - _numberToControlCardGrow)) {
      numberOfCardToSelect = Random().nextInt(ref.watch(levelProvider)) + _defaultNumberOfClickableCards;
    }

    List<int> numberofSelectableIndexes = [];
    ref.read(cardListProvider.notifier).createCardListWithLength(length: _maxCards);
    int controlVariable = 0;
    do {
      int randomIndex = Random().nextInt(_maxCards);
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

  Future<void> goToNextLevel(
      {required WidgetRef ref, required ConfettiController confettiController, required AudioPlayer audioPlayer}) async {
    if (allSelectableCardsSelected(ref: ref)) {
      ref.read(levelProvider.notifier).state++;
      if (ref.watch(levelProvider) % _baseLevelToShowconfetti == 0) {
        confettiController.play();
      }
      Future.delayed(const Duration(milliseconds: 1500), () {
        confettiController.stop();
      });
      createNewGame(ref: ref);
    }
  }

  double getGameViewMainAxisExtentDistribution({required double value}) {
    return value > 800 ? 74 : 70;
  }

  double getGameViewMainAxisSpacingDistribution({required double value, required BuildContext context}) {
    return value > 800
        ? MediaQuery.of(context).size.height / 14
        : (value > 650 ? MediaQuery.of(context).size.height / 8 : MediaQuery.of(context).size.height / 12);
  }
}
