import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hello/config/images.dart';
import 'package:hello/config/string.dart';
import 'package:hello/controller/contactController.dart';
import 'package:hello/controller/imagePicker.dart';
import 'package:hello/controller/profileControler.dart';
import 'package:hello/pages/contactPage/contactPage.dart';
import 'package:hello/pages/group/groupPage.dart';
import 'package:hello/pages/home/widgets/chatList.dart';
import 'package:hello/pages/home/widgets/tabBar.dart';
import 'package:hello/pages/profilePage/profilePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    ProfileController profileController = Get.put(ProfileController());
    ContactController contactController = Get.put(ContactController());
    ImagePickerController imagePickerController = Get.put(ImagePickerController());
    // AppController appController = Get.put(AppController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(
          textAlign: TextAlign.start,
          AppString.appName,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        leading: Padding(
          padding: const EdgeInsets.all(1.0),
          child: SvgPicture.asset(
            AssetsImage.appIconSVG,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // appController.checkLatestVersion();
            },
            icon: const Icon(
              Icons.search,
            ),
          ),
          IconButton(
            onPressed: () async {
              Get.to(const ProfilePage());
            },
            icon: const Icon(
              Icons.more_vert,
            ),
          )
        ],
        bottom: myTabBar(tabController, context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const ContactPage());
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: TabBarView(
          controller: tabController,
          children: const [
            ChatList(),
            GroupPage(),
            Center(child: Text("Notes"),)
          ],
        ),
      ),
    );
  }
}