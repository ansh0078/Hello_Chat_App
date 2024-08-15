import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello/controller/profileControler.dart';
import 'package:hello/widgets/primaryBtn.dart';

class UserUpdateProfile extends StatelessWidget {
  const UserUpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.primaryContainer),
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.image,
                            size: 40,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Text(
                            "Personal Info ",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Obx(
                            () => Text(
                              profileController.currentUser.value.name! == null ? "user" : profileController.currentUser.value.name!,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      const TextField(
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: 'Enter Your Name',
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Obx(
                            () => Text(
                              profileController.currentUser.value.email!,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      const TextField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(prefixIcon: Icon(Icons.alternate_email_rounded), hintText: "Enter Your Email"),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            "Phone",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const TextField(
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: 'Enter Your Number',
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PrimaryBtn(btnName: "Save", icon: Icons.save, ontap: () {}),
                        ],
                      )
                    ],
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}