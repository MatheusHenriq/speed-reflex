import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speed_reflect/modules/providers/card_provider.dart';

import '../game/model/card_model.dart';

class GameController {
  final int maxCards = 15;

  final cardListProvider = StateNotifierProvider<CardNotified, List<CardModel>>((
    ref,
  ) {
    return CardNotified();
  });

  void createRandomCard({required WidgetRef ref}) {
    int numberOfCardToSelect = Random().nextInt(maxCards - 3) + 3;
    List<CardModel> cardListModel = [];
    List<int> numberofSelectableIndexes = [];
    for (var i = 0; i < maxCards; i++) {
      cardListModel.add(CardModel(isActive: false, isSelected: false));
    }
    int controlVariable = 0;
    do {
      int randomIndex = Random().nextInt(maxCards);
      if (!numberofSelectableIndexes.contains(randomIndex)) {
        cardListModel[randomIndex] = CardModel(isActive: true, isSelected: false);
        controlVariable++;
      }
    } while (controlVariable < numberOfCardToSelect);
    ref.invalidate(cardListProvider);
    ref.read(cardListProvider.notifier).clearAndSetData(cardListData: cardListModel);
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
