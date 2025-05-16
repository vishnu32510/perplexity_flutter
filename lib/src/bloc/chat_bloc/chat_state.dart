part of 'chat_bloc.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatStreaming extends ChatState {
  final String response;
  ChatStreaming(this.response);
}

class ChatCompleted extends ChatState {
  final String fullResponse;
  ChatCompleted(this.fullResponse);
}

class ChatError extends ChatState {
  final String message;
  ChatError(this.message);
}