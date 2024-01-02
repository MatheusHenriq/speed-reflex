import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    int numberOfCardToSelect = Random().nextInt(12) + 3;

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

  bool allSelectableCardsSelected() {
    print("object");
    for (var i = 0; i < cardModelList.length; i++) {
      if (cardModelList[i] == CardModel(isActive: true, isSelected: false)) {
        return false;
      }
    }

    return true;
  }

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);
    createRandomCard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    onPressed: () {
                      setState(
                        () {
                          cardModelList[index] = CardModel(isActive: cardModelList[index]?.isActive, isSelected: true);
                        },
                      );
                    },
                    cardData: cardModelList[index] ?? CardModel(),
                  ),
                ),
                itemCount: maxCards,
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
                    color: !cardModelList.contains(CardModel(isActive: true, isSelected: true)) ? Colors.green : Colors.grey,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    onPressed: () => createRandomCard(),
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
