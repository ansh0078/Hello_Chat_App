import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hello/bloc/chat_bloc.dart';
import 'package:hello/controller/profileControler.dart';
import 'package:hello/model/chat_message_model.dart';
import 'package:lottie/lottie.dart';

class AiChatPage extends StatefulWidget {
  const AiChatPage({super.key});

  @override
  State<AiChatPage> createState() => _AiChatPageState();
}

class _AiChatPageState extends State<AiChatPage> {
  final ChatBloc chatBloc = ChatBloc();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    return Scaffold(
      body: BlocConsumer<ChatBloc, ChatState>(
        bloc: chatBloc,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case ChatSuccessState:
              List<ChatMessageModel> message = (state as ChatSuccessState).messages;
              return Container(
                width: double.maxFinite,
                height: double.maxFinite,
                decoration: const BoxDecoration(
                  image: DecorationImage(opacity: 0.5, image: AssetImage("assets/images/rocket_background.jpg"), fit: BoxFit.cover),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 25,
                      margin: const EdgeInsets.only(top: 40),
                      child: Row(
                        children: [
                          Text(
                            'Hello Pod AI',
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: message.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  margin: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.amber.withOpacity(0.1),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        message[index].role == "user" ? profileController.currentUser.value.name.toString() : "Hello Pod AI",
                                        style: TextStyle(color: message[index].role == "user" ? Colors.amber : Colors.purple.shade200, fontSize: 18),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      SelectableText(
                                        showCursor: true,
                                        message[index].parts.first.text,
                                        style: const TextStyle(height: 1.2, fontSize: 18),
                                      ),
                                    ],
                                  ));
                            })),
                    if (chatBloc.generating)
                      Row(
                        children: [
                          SizedBox(height: 100, width: 100, child: Lottie.asset('assets/animination/Loading_animation.json')),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text('Loading...')
                        ],
                      ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextField(
                                  controller: textEditingController,
                                  style: const TextStyle(color: Colors.white),
                                  cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      fillColor: Colors.transparent,
                                      hintText: "Ask something from AI",
                                      hintStyle: TextStyle(color: Colors.grey.shade300),
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100), borderSide: const BorderSide(color: Colors.white))))),
                          const SizedBox(width: 12),
                          InkWell(
                              onTap: () {
                                if (textEditingController.text.isNotEmpty) {
                                  String text = textEditingController.text;
                                  textEditingController.clear();
                                  chatBloc.add(ChatGenerateNewTextMessageEvent(inputMessage: text));
                                }
                              },
                              child: Container(
                                width: 55,
                                height: 55,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), border: Border.all(color: Colors.white, width: 1)),
                                child: Center(
                                  child: Icon(Icons.send_outlined),
                                ),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
