import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello/config/images.dart';
import 'package:hello/controller/authController.dart';
import 'package:hello/controller/profileControler.dart';
import 'package:hello/model/userModel.dart';
import 'package:hello/pages/userProfile/widgets/userInfo.dart';

class UserProfilePage extends StatelessWidget {
  final UserModel userModel;
  const UserProfilePage({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    ProfileController profileController = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            onPressed: () {
            },
            icon: const Icon(
              Icons.edit,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            LoginUserInfo(
              profileImage: userModel.profileImage ?? AssetsImage.defaultProfileUrl,
              userName: userModel.name ?? "user",
              userEmail: userModel.email ?? "",
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                authController.logoutUser();
              },
              child: const Text("Logout"),
            )
          ],
        ),
      ),
    );
  }
}