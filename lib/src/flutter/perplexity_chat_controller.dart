import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perplexity_dart/perplexity_dart.dart';
import 'package:perplexity_flutter/perplexity_flutter.dart';

/// Controller for interacting with the chat functionality.
class PerplexityChatController {
  /// The build context used to access the ChatBloc.
  final BuildContext context;

  /// Creates a new chat controller with the specified context.
  PerplexityChatController._(this.context);

  /// Gets a controller instance for the specified context.
  ///
  /// [context] must have a ChatBloc available in the widget tree.
  static PerplexityChatController of(BuildContext context) {
    return PerplexityChatController._(context);
  }

  /// Submits a prompt to the Perplexity API.
  ///
  /// [requestModel] contains the prompt and configuration.
  /// [stream] determines whether to use streaming (defaults to true).
  void submit({required ChatRequestModel requestModel, bool stream = true}) {
    final bloc = context.read<ChatBloc>();
    bloc.add(ChatPromptSubmitted(requestModel, stream: stream));
  }
}
