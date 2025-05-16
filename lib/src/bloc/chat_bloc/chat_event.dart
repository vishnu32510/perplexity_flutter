part of 'chat_bloc.dart';

abstract class ChatEvent {}


class ChatPromptSubmitted extends ChatEvent {
  final String prompt;
  final bool stream;

  ChatPromptSubmitted(this.prompt, {this.stream = true});
}
