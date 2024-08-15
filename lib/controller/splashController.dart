import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hello/pages/home/homePage.dart';
import 'package:hello/pages/welcome/wekcomePage.dart';

class SplaceController extends GetxController {
  final auth = FirebaseAuth.instance;

  void onInit() async {
    super.onInit();
    splashHandle();
  }

  void splashHandle() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );
    if (auth.currentUser == null) {
      Get.to(const WelcomePage());
    } else {
      Get.to(const HomePage());
      print(auth.currentUser!.email);
    }
  }
}