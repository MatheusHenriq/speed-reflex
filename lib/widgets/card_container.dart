import 'package:flutter/material.dart';
import 'package:speed_reflect/modules/game/model/card_model.dart';

class CardContainer extends StatefulWidget {
  final CardModel cardData;
  final Function() onPressed;
  const CardContainer({super.key, required this.cardData, required this.onPressed});

  @override
  State<CardContainer> createState() => _CardContainerState();
}

class _CardContainerState extends State<CardContainer> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(50),
      color: (widget.cardData.isActive ?? false) ? (isSelected ? Colors.brown[200] : Colors.red) : Colors.brown[200],
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () {
          setState(() {
            isSelected = true;
          });
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width * 0.12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.black, width: 1),
          ),
        ),
      ),
    );
  }
}
