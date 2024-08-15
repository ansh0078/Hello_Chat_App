import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hello/config/images.dart';
import 'package:hello/controller/splashController.dart';

class SplacePage extends StatelessWidget {
  const SplacePage({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    SplaceController splaceController = Get.put(SplaceController());
    return Scaffold(
        body: Center(
      child: SvgPicture.asset(AssetsImage.appIconSVG),
    ));
  }
}
