import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perplexity_dart/perplexity_dart.dart';

class PerplexityChatView extends StatelessWidget {
  final Widget Function(String response)? successBuilder;
  final Widget Function(String message)? errorBuilder;
  final Widget? placeholder;

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
              : Text("Error: ${state.message}", style: const TextStyle(color: Colors.red));
        }

        return placeholder ?? const Text("Enter a prompt to begin...");
      },
    );
  }
}
