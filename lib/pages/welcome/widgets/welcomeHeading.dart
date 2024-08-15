import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hello/config/images.dart';
import 'package:hello/config/string.dart';

class WelcomeHeading extends StatelessWidget {
  const WelcomeHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AssetsImage.appIconSVG,
              height: 150,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ],
        ),
        Text(AppString.appName, style: Theme.of(context).textTheme.headlineLarge)
      ],
    );
  }
}