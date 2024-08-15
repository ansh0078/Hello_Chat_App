import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello/config/images.dart';
import 'package:hello/controller/chatController.dart';
import 'package:hello/controller/contactController.dart';
import 'package:hello/controller/profileControler.dart';
import 'package:hello/pages/chat/chatPage.dart';
import 'package:hello/pages/contactPage/widgets/constactSearch.dart';
import 'package:hello/pages/contactPage/widgets/newContactTile.dart';
import 'package:hello/pages/group/widgets/newGroup.dart';
import 'package:hello/pages/home/widgets/chatTitle.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isSearchEnable = false.obs;
    ContactController contactController = Get.put(ContactController());
    ChatController chatController = Get.put(ChatController());
    ProfileController profileController = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Contact"),
        actions: [
          Obx(
            () => IconButton(
              onPressed: () {
                isSearchEnable.value = !isSearchEnable.value;
              },
              icon: isSearchEnable.value ? const Icon(Icons.close) : const Icon(Icons.search),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Obx(
              () => isSearchEnable.value ? const ContactSearch() : const SizedBox(),
            ),
            const SizedBox(height: 10),
            NewContactTile(
              btnName: "New Contact",
              icon: Icons.person_add,
              ontap: () {},
            ),
            const SizedBox(height: 20),
            NewContactTile(
              btnName: "New Group",
              icon: Icons.person_add,
              ontap: () {
                Get.to(const NewGroup());
              },
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Text("Contacts on Hello")
              ],
            ),
            const SizedBox(height: 10),
            Obx(
              () => Column(
                  children: contactController.userList
                      .map(
                        (e) => InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            Get.to(ChatPage(userModel: e));
                          },
                          child: ChatTile(
                            imageUrl: e.profileImage ?? AssetsImage.defaultProfileUrl,
                            name: e.name ?? "User",
                            lastChat: e.about ?? "New Message...",
                            lastTime: e.email == profileController.currentUser.value.email ? "you" : " ",
                          ),
                        ),
                      )
                      .toList()),
            )
          ],
        ),
      ),
    );
  }
}
