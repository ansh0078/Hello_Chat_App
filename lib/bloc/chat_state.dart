part of 'chat_bloc.dart';

abstract class ChatState {}

class ChatSuccessState extends ChatState {
  final List<ChatMessageModel> messages;

  ChatSuccessState({required this.messages});
}
