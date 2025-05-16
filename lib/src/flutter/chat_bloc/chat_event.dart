part of 'chat_bloc.dart';

abstract class ChatEvent {}

class ChatPromptSubmitted extends ChatEvent {
  final ChatRequestModel requestModel;
  final bool stream;

  ChatPromptSubmitted(this.requestModel, {this.stream = true});
}
