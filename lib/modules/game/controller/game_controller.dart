import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speed_reflect/modules/providers/card_provider.dart';

import '../model/card_model.dart';

class GameController {
  final int maxCards = 15;

  final cardListProvider = StateNotifierProvider<CardNotified, List<CardModel>>((
    ref,
  ) {
    return CardNotified();
  });

  Future createNewGame({required WidgetRef ref}) async {
    ref.read(cardListProvider.notifier).clearAndSetData(cardListData: []);
    int numberOfCardToSelect = Random().nextInt(maxCards - 3) + 3;
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
    for (var i = 0; i < ref.read(cardListProvider.notifier).readCard().length; i++) {
      if (ref.read(cardListProvider.notifier).readCard()[i] == CardModel(isActive: true, isSelected: false)) {
        return false;
      }
    }

    return true;
  }
}
