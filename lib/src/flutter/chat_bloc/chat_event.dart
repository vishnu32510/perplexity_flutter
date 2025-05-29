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
  ChatPromptSubmitted(this.requestModel, {this.stream = true});
}

/// Event triggered when an image-based prompt is submitted.
class ChatImagePromptSubmitted extends ChatEvent {
  /// The request model containing the prompt and configuration.
  final ChatRequestModel requestModel;

  /// Whether to stream the response or get it all at once.
  final bool stream;

  /// Creates a new image prompt submission event.
  ChatImagePromptSubmitted(this.requestModel, {this.stream = true});
}

/// Event triggered when a search-based prompt is submitted.
class ChatSearchPromptSubmitted extends ChatEvent {
  /// The request model containing the prompt and configuration.
  final ChatRequestModel requestModel;

  /// Whether to stream the response or get it all at once.
  final bool stream;

  /// Optional domain filters for the search.
  final List<String>? searchDomains;

  /// Optional recency filter for the search.
  final String? recencyFilter;

  /// Creates a new search prompt submission event.
  ChatSearchPromptSubmitted(
    this.requestModel, {
    this.stream = true,
    this.searchDomains,
    this.recencyFilter,
  });
}