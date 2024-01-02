import 'dart:math';

import 'package:flutter/material.dart';

import '../../../widgets/card_container.dart';
import '../model/card_model.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  List<CardModel?> cardModelList = [];
  int maxCards = 15;
  void createRandomCard() {
    cardModelList.clear();
    int numberOfCardToSelect = Random().nextInt(9) + 3;

    List<int> numberofSelectableIndexes = [];
    int controlVariable = 0;
    for (var i = 0; i < maxCards; i++) {
      cardModelList.add(CardModel(isActive: false, isSelected: false));
    }

    do {
      int randomIndex = Random().nextInt(maxCards);
      if (!numberofSelectableIndexes.contains(randomIndex)) {
        setState(() {
          cardModelList[randomIndex] = CardModel(isActive: true, isSelected: false);
        });

        controlVariable++;
      }
    } while (controlVariable < numberOfCardToSelect);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    createRandomCard();
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () => createRandomCard()),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) => CardContainer(
          cardData: cardModelList[index] ?? CardModel(),
        ),
        itemCount: maxCards,
      ),
    );
  }
}
