import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speed_reflect/core/constants/app_images.dart';

import '../controller/landing_controller.dart';

class LandingView extends StatelessWidget {
  final LandingController controller;
  const LandingView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 72,
          title: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 18),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.settings,
                  size: 34,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            Image.asset(
              AppImages.landingBackgroundImageJPEG,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      "Speed Reflex",
                      style: TextStyle(
                        fontSize: 46,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: Consumer(builder: (context, ref, child) {
                      return TextButton(
                        onPressed: () => controller.goToGamePage(ref: ref),
                        child: const Text(
                          "Play now",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
