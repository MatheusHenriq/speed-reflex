import 'package:riverpod/riverpod.dart';
import 'package:speed_reflect/modules/game/model/card_model.dart';

class CardNotified extends StateNotifier<List<CardModel>> {
  CardNotified() : super([]);

  void createCard({required CardModel cardData}) {
    state = [...state, cardData];
  }

  List<CardModel> readCard() {
    return state;
  }

  void createCardListWithLength({required int length}) {
    for (var i = 0; i < length; i++) {
      createCard(cardData: CardModel(isActive: false, isSelected: false));
    }
  }

  void clearAndSetData({
    required List<CardModel> cardListData,
  }) {
    List<CardModel> data = cardListData;
    state.clear();
    for (var i = 0; i < (data.length); i++) {
      state.add(data[i]);
    }
  }

  void clear() {
    state.clear();
  }

  void updateCard({required List<CardModel> cardList, required CardModel cardData, required int index}) {
    List<CardModel> data = [];
    for (int i = 0; i < state.length; i++) {
      data.add(state[i]);
    }
    data[index] = cardData;
    state.clear();

    for (var i = 0; i < data.length; i++) {
      state = [...state, data[i]];
    }
  }

  void deleteCard({required CardModel petData}) {
    if (state.length == 1) {
      state.clear();
      state = [];
    } else {
      List<CardModel> data = [];
      for (int i = 0; i < state.length; i++) {
        data.add(state[i]);
      }

      state.clear();

      for (var i = 0; i < data.length; i++) {
        state = [...state, data[i]];
      }
    }
  }
}
