import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:speed_reflect/core/constants/app_sounds.dart';
import 'package:speed_reflect/modules/game/model/card_model.dart';

class CardContainer extends StatefulWidget {
  final CardModel cardData;
  final Function(CardModel) onTap;
  const CardContainer({
    super.key,
    required this.cardData,
    required this.onTap,
  });

  @override
  State<CardContainer> createState() => _CardContainerState();
}

class _CardContainerState extends State<CardContainer> {
  late AudioPlayer player;
  @override
  void initState() {
    player = AudioPlayer();
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(50),
      color: ((widget.cardData.isActive ?? false) && !(widget.cardData.isSelected ?? false)) ? Colors.red : Colors.brown[200],
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTapCancel: () async {
          if (widget.cardData.isActive ?? false) {
            await player.play(
              AssetSource(
                AppSounds.correctClickSound,
              ),
            );
            widget.onTap(
              CardModel(
                isActive: false,
                isSelected: true,
              ),
            );
          } else {
            widget.onTap(
              CardModel(
                isActive: false,
                isSelected: false,
              ),
            );
            await player.play(
              AssetSource(
                AppSounds.wrongClickSound,
              ),
            );
          }
        },
        onTap: () async {
          if (widget.cardData.isActive ?? false) {
            await player.play(
              AssetSource(
                AppSounds.correctClickSound,
              ),
            );
            widget.onTap(
              CardModel(
                isActive: false,
                isSelected: true,
              ),
            );
          } else {
            widget.onTap(
              CardModel(
                isActive: false,
                isSelected: false,
              ),
            );
            await player.play(
              AssetSource(
                AppSounds.wrongClickSound,
              ),
            );
          }
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.22,
          width: MediaQuery.of(context).size.width * 0.22,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.black, width: 1),
          ),
        ),
      ),
    );
  }
}
