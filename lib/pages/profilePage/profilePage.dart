import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello/controller/authController.dart';
import 'package:hello/controller/imagePicker.dart';
import 'package:hello/controller/profileControler.dart';
import 'package:hello/widgets/primaryBtn.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isEdit = false.obs;
    ProfileController profileController = Get.put(ProfileController());
    TextEditingController name = TextEditingController(text: profileController.currentUser.value.name);
    TextEditingController email = TextEditingController(text: profileController.currentUser.value.email);
    TextEditingController phone = TextEditingController(text: profileController.currentUser.value.phoneNumber);
    TextEditingController about = TextEditingController(text: profileController.currentUser.value.about);
    ImagePickerController imagePickerController = Get.put(ImagePickerController());
    RxString imagePath = "".obs;
    AuthController authController = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            onPressed: () {
              authController.logoutUser();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                              () => isEdit.value
                                  ? InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        imagePath.value = await imagePickerController.pickImage(ImageSource.gallery);
                                      },
                                      child: Container(
                                        height: 200,
                                        width: 200,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.background,
                                          borderRadius: BorderRadius.circular(100),
                                        ),
                                        child: imagePath.value == ""
                                            ? const Icon(
                                                Icons.add,
                                              )
                                            : ClipRRect(
                                                borderRadius: BorderRadius.circular(100),
                                                child: Image.file(
                                                  File(imagePath.value),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                      ),
                                    )
                                  : Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.background,
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      child: profileController.currentUser.value.profileImage == null || profileController.currentUser.value.profileImage == ""
                                          ? const Icon(
                                              Icons.image,
                                            )
                                          : ClipRRect(
                                              borderRadius: BorderRadius.circular(100),
                                              child: CachedNetworkImage(
                                                imageUrl: profileController.currentUser.value.profileImage!,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) => const CircularProgressIndicator(),
                                                errorWidget: (context, url, error) => const Icon(Icons.error),
                                              ),
                                            ),
                                    ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Obx(
                          () => TextField(
                            controller: name,
                            enabled: isEdit.value,
                            decoration: InputDecoration(
                              filled: isEdit.value,
                              labelText: "Name",
                              prefixIcon: const Icon(
                                Icons.person,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Obx(
                          () => TextField(
                            controller: about,
                            enabled: isEdit.value,
                            decoration: InputDecoration(
                              filled: isEdit.value,
                              labelText: "About",
                              prefixIcon: const Icon(
                                Icons.info,
                              ),
                            ),
                          ),
                        ),
                        TextField(
                          controller: email,
                          enabled: false,
                          decoration: InputDecoration(
                            filled: isEdit.value,
                            labelText: "Email",
                            prefixIcon: const Icon(
                              Icons.alternate_email_rounded,
                            ),
                          ),
                        ),
                        Obx(
                          () => TextField(
                            controller: phone,
                            enabled: isEdit.value,
                            decoration: InputDecoration(
                              filled: isEdit.value,
                              labelText: "Phone",
                              prefixIcon: const Icon(
                                Icons.phone,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                              () => isEdit.value
                                  ? PrimaryBtn(
                                      btnName: "Save",
                                      icon: Icons.save,
                                      ontap: () async {
                                        await profileController.updateProfile(imagePath.value, name.text, about.text, phone.text);
                                        isEdit.value = false;
                                      },
                                    )
                                  : PrimaryBtn(
                                      btnName: "Edit",
                                      icon: Icons.edit,
                                      ontap: () {
                                        isEdit.value = true;
                                      },
                                    ),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
