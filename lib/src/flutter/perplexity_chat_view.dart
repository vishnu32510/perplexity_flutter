import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'chat_bloc/chat_bloc.dart';

/// A widget that displays chat responses from the Perplexity API.
class PerplexityChatView extends StatelessWidget {
  /// Optional builder for customizing the successful response display.
  final Widget Function(String response)? successBuilder;

  /// Optional builder for customizing the error display.
  final Widget Function(String message)? errorBuilder;

  /// Optional widget to display when there's no response yet.
  final Widget? placeholder;

  /// Creates a new chat view widget.
  ///
  /// [successBuilder] customizes how successful responses are displayed.
  /// [errorBuilder] customizes how errors are displayed.
  /// [placeholder] is shown before any response is received.
  const PerplexityChatView({
    super.key,
    this.successBuilder,
    this.errorBuilder,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is ChatStreaming || state is ChatCompleted) {
          final response = state is ChatStreaming
              ? state.response
              : (state as ChatCompleted).fullResponse;

          return successBuilder != null
              ? successBuilder!(response)
              : SingleChildScrollView(
                  child: Text(response, style: const TextStyle(fontSize: 16)),
                );
        }

        if (state is ChatError) {
          return errorBuilder != null
              ? errorBuilder!(state.message)
              : Text("Error: ${state.message}",
                  style: const TextStyle(color: Colors.red));
        }

        return placeholder ?? const Text("Enter a prompt to begin...");
      },
    );
  }
}
