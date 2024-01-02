import 'package:flutter/material.dart';
import 'package:speed_reflect/modules/game/model/card_model.dart';

class CardContainer extends StatefulWidget {
  final CardModel cardData;
  const CardContainer({super.key, required this.cardData});

  @override
  State<CardContainer> createState() => _CardContainerState();
}

class _CardContainerState extends State<CardContainer> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: (widget.cardData.isActive ?? false) ? (isSelected ? Colors.brown[200] : Colors.red) : Colors.brown[200],
      child: InkWell(
        onTap: () {
          isSelected = true;
          setState(() {});
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
          ),
        ),
      ),
    );
  }
}
