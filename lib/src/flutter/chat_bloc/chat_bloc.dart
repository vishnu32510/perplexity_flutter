import 'package:bloc/bloc.dart';
import 'package:perplexity_flutter/perplexity_flutter.dart';
part 'chat_event.dart';
part 'chat_state.dart';

/// BLoC for managing chat state and interactions with the Perplexity API.
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  /// The Perplexity client used to make API requests.
  final PerplexityClient client;

  /// Creates a new ChatBloc with the specified Perplexity client.
  ///
  /// [client] is required for making API requests.
  ChatBloc({required this.client}) : super(ChatInitial()) {
    on<ChatPromptSubmitted>(_onPromptSubmitted);
  }

  /// Handles the submission of a new prompt to the Perplexity API.
  ///
  /// [event] contains the request model and streaming preference.
  /// [emit] is used to emit new states during the request lifecycle.
  Future<void> _onPromptSubmitted(
      ChatPromptSubmitted event, Emitter<ChatState> emit) async {
    try {
      emit(ChatStreaming(''));
      String buffer = '';

      if (event.stream) {
        // Streaming
        final stream = client.streamChat(requestModel: event.requestModel);
        await for (final chunk in stream) {
          buffer += chunk;
          emit(ChatStreaming(buffer));
        }
      } else {
        // Full response
        final response = await client.sendMessage(requestModel: event.requestModel);
        buffer = response.content;
        emit(ChatStreaming(buffer));
      }

      emit(ChatCompleted(buffer));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }
}
