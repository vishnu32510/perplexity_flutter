import 'package:bloc/bloc.dart';
import 'package:perplexity_flutter/perplexity_flutter.dart';
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final PerplexityClient client;

  ChatBloc({required this.client}) : super(ChatInitial()) {
    on<ChatPromptSubmitted>(_onPromptSubmitted);
  }

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
