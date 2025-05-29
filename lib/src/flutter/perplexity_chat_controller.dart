import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perplexity_flutter/perplexity_flutter.dart';

/// Controller for interacting with the chat functionality.
class PerplexityChatController {
  /// The build context used to access the ChatBloc.
  final BuildContext context;

  /// Creates a new chat controller with the specified context.
  PerplexityChatController._(this.context);

  /// Gets a controller instance for the specified context.
  static PerplexityChatController of(BuildContext context) {
    return PerplexityChatController._(context);
  }

  /// Submits a prompt to the Perplexity API.
  void submit({required ChatRequestModel requestModel, bool stream = true}) {
    final bloc = context.read<ChatBloc>();
    bloc.add(ChatPromptSubmitted(requestModel, stream: stream));
  }

  /// Submits an image-based prompt to the Perplexity API.
  void submitWithImage({required ChatRequestModel requestModel, bool stream = true}) {
    final bloc = context.read<ChatBloc>();
    bloc.add(ChatImagePromptSubmitted(requestModel, stream: stream));
  }

  /// Submits a search-based prompt to the Perplexity API.
  void submitWithSearch({
    required ChatRequestModel requestModel,
    bool stream = true,
    List<String>? searchDomains,
    String? recencyFilter,
  }) {
    final bloc = context.read<ChatBloc>();
    bloc.add(ChatSearchPromptSubmitted(
      requestModel,
      stream: stream,
      searchDomains: searchDomains,
      recencyFilter: recencyFilter,
    ));
  }
}