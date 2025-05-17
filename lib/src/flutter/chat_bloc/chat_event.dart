part of 'chat_bloc.dart';

/// Base class for all chat events.
abstract class ChatEvent {}

/// Event triggered when a prompt is submitted to the API.
class ChatPromptSubmitted extends ChatEvent {
  /// The request model containing the prompt and configuration.
  final ChatRequestModel requestModel;
  
  /// Whether to stream the response or get it all at once.
  final bool stream;
  
  /// Creates a new prompt submission event.
  ///
  /// [requestModel] contains the prompt and configuration.
  /// [stream] determines whether to use streaming (defaults to true).
  ChatPromptSubmitted(this.requestModel, {this.stream = true});
}
