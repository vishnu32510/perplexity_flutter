part of 'chat_bloc.dart';

/// Base class for all chat states.
abstract class ChatState {}

/// Initial state before any chat interaction.
class ChatInitial extends ChatState {}

/// State during streaming of a response.
class ChatStreaming extends ChatState {
  /// The partial response text received so far.
  final String response;

  /// Creates a new streaming state with the current partial response.
  ChatStreaming(this.response);
}

/// State when a response is fully received.
class ChatCompleted extends ChatState {
  /// The complete response text.
  final String fullResponse;

  /// Creates a new completed state with the full response.
  ChatCompleted(this.fullResponse);
}

/// State when an error occurs during chat.
class ChatError extends ChatState {
  /// The error message.
  final String message;

  /// Creates a new error state with the error message.
  ChatError(this.message);
}
