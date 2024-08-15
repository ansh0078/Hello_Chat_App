import 'package:flutter/material.dart';
import 'package:hello/Pages/Welcome/Widgets/welcomebody.dart';
import 'package:hello/Pages/Welcome/Widgets/welcomeheading.dart';
import 'package:hello/Pages/Welcome/Widgets/welcomefooterbtn.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              WelcomeHeading(),
              WelcomeBody(),
              WelcomeFooterBtn(),
            ],
          ),
        ),
      ),
    );
  }
}