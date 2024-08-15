import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello/config/images.dart';
import 'package:hello/controller/chatController.dart';
import 'package:hello/controller/contactController.dart';
import 'package:hello/controller/profileControler.dart';
import 'package:hello/model/chatRoomModel.dart';
import 'package:hello/pages/chat/chatPage.dart';
import 'package:hello/pages/home/widgets/chatTitle.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    ContactController contactController = Get.put(ContactController());
    ProfileController profileController = Get.put(ProfileController());
    ChatController chatController = Get.put(ChatController());
    return StreamBuilder<List<ChatRoomModel>>(
      stream: contactController.getChatRoom(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        List<ChatRoomModel>? e = snapshot.data;

        return ListView.builder(
          itemCount: e!.length,
          itemBuilder: (context, index) {
            return InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                chatController.markMessagesAsRead(e[index].id!);
                Get.to(
                  ChatPage(
                    userModel: (e[index].receiver!.id == profileController.currentUser.value.id ? e[index].sender : e[index].receiver)!,
                  ),
                );
              },
              child: ChatTile(
                imageUrl: (e[index].receiver!.id == profileController.currentUser.value.id ? e[index].sender!.profileImage : e[index].receiver!.profileImage) ?? AssetsImage.defaultProfileUrl,
                name: (e[index].receiver!.id == profileController.currentUser.value.id ? e[index].sender!.name : e[index].receiver!.name)!,
                lastChat: e[index].lastMessage ?? "Last Message",
                lastTime: e[index].lastMessageTimestamp ?? "Last Time",
              ),
            );
          },
        );
      },
    );
  }
}
