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

  void updateCard({required CardModel cardData, required int index}) {
    state[index] = cardData;
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
