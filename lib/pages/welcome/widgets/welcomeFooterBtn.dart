import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hello/Config/images.dart';
import 'package:hello/Config/string.dart';
import 'package:hello/pages/auth/authPage.dart';
import 'package:slide_to_act/slide_to_act.dart';

class WelcomeFooterBtn extends StatelessWidget {
  const WelcomeFooterBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return SlideAction(
      onSubmit: () {
        Get.to(const AuthPage());
      },
      // ignore: sized_box_for_whitespace
      sliderButtonIcon: Container(
        width: 25,
        height: 25,
        child: SvgPicture.asset(
          AssetsImage.plugSVG,
          width: 25,
        ),
      ),
      text: WelcomePageString.slideToStart,
      textStyle: Theme.of(context).textTheme.labelLarge,
      sliderRotate: false,
      submittedIcon: SvgPicture.asset(
        AssetsImage.connectSVG,
        width: 25,
      ),
      innerColor: Theme.of(context).colorScheme.primary,
      outerColor: Theme.of(context).colorScheme.primaryContainer,
    );
  }
}
