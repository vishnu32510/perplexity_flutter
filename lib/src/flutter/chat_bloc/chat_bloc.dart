import 'package:bloc/bloc.dart';
import 'package:perplexity_dart/perplexity_dart.dart';
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
    on<ChatImagePromptSubmitted>(_onImagePromptSubmitted);
    on<ChatSearchPromptSubmitted>(_onSearchPromptSubmitted);
  }

  /// Handles the submission of a new prompt to the Perplexity API.
  Future<void> _onPromptSubmitted(
      ChatPromptSubmitted event, Emitter<ChatState> emit) async {
    try {
      emit(ChatStreaming(''));
      String buffer = '';

      if (event.stream) {
        final stream = client.streamChat(requestModel: event.requestModel);
        await for (final chunk in stream) {
          buffer += chunk;
          emit(ChatStreaming(buffer));
        }
      } else {
        final response = await client.sendMessage(requestModel: event.requestModel);
        buffer = response.content;
        emit(ChatStreaming(buffer));
      }

      emit(ChatCompleted(buffer));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  /// Handles image-based prompts using the Perplexity API.
  Future<void> _onImagePromptSubmitted(
      ChatImagePromptSubmitted event, Emitter<ChatState> emit) async {
    try {
      emit(ChatStreaming(''));
      String buffer = '';

      if (event.stream) {
        final stream = client.streamChat(
          requestModel: event.requestModel.copyWith(
            returnImages: true,
          ),
        );
        await for (final chunk in stream) {
          buffer += chunk;
          emit(ChatStreaming(buffer));
        }
      } else {
        final response = await client.sendMessage(
          requestModel: event.requestModel.copyWith(
            returnImages: true,
          ),
        );
        buffer = response.content;
        emit(ChatStreaming(buffer));
      }

      emit(ChatCompleted(buffer));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  /// Handles search-based prompts using the Perplexity API.
  Future<void> _onSearchPromptSubmitted(
      ChatSearchPromptSubmitted event, Emitter<ChatState> emit) async {
    try {
      emit(ChatStreaming(''));
      String buffer = '';

      if (event.stream) {
        final stream = client.streamChat(
          requestModel: event.requestModel.copyWith(
            returnRelatedQuestions: true,
            searchDomainFilter: event.searchDomains,
            searchRecencyFilter: event.recencyFilter,
          ),
        );
        await for (final chunk in stream) {
          buffer += chunk;
          emit(ChatStreaming(buffer));
        }
      } else {
        final response = await client.sendMessage(
          requestModel: event.requestModel.copyWith(
            returnRelatedQuestions: true,
            searchDomainFilter: event.searchDomains,
            searchRecencyFilter: event.recencyFilter,
          ),
        );
        buffer = response.content;
        emit(ChatStreaming(buffer));
      }

      emit(ChatCompleted(buffer));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }
}