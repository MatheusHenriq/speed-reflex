import 'package:flutter/material.dart';

class LandingSettings extends StatelessWidget {
  const LandingSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Configuração",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          children: [],
        ),
      ),
    );
  }
}
