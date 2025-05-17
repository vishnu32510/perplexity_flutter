import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perplexity_flutter/perplexity_flutter.dart';

/// A widget that provides a ChatBloc to its descendants.
///
/// This widget should be placed at the top of your widget tree to make
/// the chat functionality available throughout your application.
class ChatWrapperWidget extends StatelessWidget {
  /// The API key for authenticating with Perplexity AI.
  final String apiKey;

  /// The child widget that will have access to the ChatBloc.
  final Widget child;

  /// The Perplexity model to use for generating responses.
  final PerplexityModel model;

  /// Creates a new chat wrapper widget.
  ///
  /// [apiKey] is required for authentication with the Perplexity API.
  /// [child] is the widget that will have access to the ChatBloc.
  /// [model] specifies which model to use (defaults to sonar).
  const ChatWrapperWidget({
    super.key,
    required this.apiKey,
    required this.child,
    this.model = PerplexityModel.sonar,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatBloc(client: PerplexityClient(apiKey: apiKey)),
      child: child,
    );
  }
}
