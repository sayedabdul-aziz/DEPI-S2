part of 'chat_cubit.dart';

sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {}

final class ChatSuccess extends ChatState {
  final List<ChatMessageModel> messages;

  ChatSuccess(this.messages);
}

final class ChatFailure extends ChatState {
  final String message;

  ChatFailure(this.message);
}
