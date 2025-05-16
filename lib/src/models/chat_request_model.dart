import 'model.dart';

class ChatRequestModel {
  final PerplexityModel model;
  final List<MessageModel> messages;
  final bool? stream;
  final int? maxTokens;
  final double? temperature;
  final double? topP;
  final List<String>? searchDomainFilter;
  final bool? returnImages;
  final bool? returnRelatedQuestions;
  final String? searchRecencyFilter;
  final int? topK;
  final double? presencePenalty;
  final double? frequencyPenalty;
  final Map<String, dynamic>? responseFormat;
  final Map<String, dynamic>? webSearchOptions;

  ChatRequestModel({
    required this.model,
    required this.messages,
    this.maxTokens,
    this.temperature,
    this.topP,
    this.searchDomainFilter,
    this.returnImages,
    this.returnRelatedQuestions,
    this.searchRecencyFilter,
    this.topK,
    this.stream,
    this.presencePenalty,
    this.frequencyPenalty,
    this.responseFormat,
    this.webSearchOptions,
  });

  factory ChatRequestModel.defaultRequest(
  {required String prompt, 
  bool? stream,
  PerplexityModel? model,
}) {
  return ChatRequestModel(
    stream: stream ?? true,
    model: model ?? PerplexityModel.sonar,
    messages: [
      MessageModel(
        role: MessageRole.system,
        content: 'Be precise and concise.',
      ),
      MessageModel(
        role: MessageRole.user,
        content: prompt,
      ),
    ],
  );
}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      'model': model.name,
      'messages': messages.map((m) => m.toJson()).toList(),
    };

    if (maxTokens != null) json['max_tokens'] = maxTokens;
    if (temperature != null) json['temperature'] = temperature;
    if (topP != null) json['top_p'] = topP;
    if (searchDomainFilter != null)
      json['search_domain_filter'] = searchDomainFilter;
    if (returnImages != null) json['return_images'] = returnImages;
    if (returnRelatedQuestions != null)
      json['return_related_questions'] = returnRelatedQuestions;
    if (searchRecencyFilter != null)
      json['search_recency_filter'] = searchRecencyFilter;
    if (topK != null) json['top_k'] = topK;
    if (stream != null) json['stream'] = stream;
    if (presencePenalty != null) json['presence_penalty'] = presencePenalty;
    if (frequencyPenalty != null) json['frequency_penalty'] = frequencyPenalty;
    if (responseFormat != null) json['response_format'] = responseFormat;
    if (webSearchOptions != null) json['web_search_options'] = webSearchOptions;

    return json;
  }
}

extension ChatRequestModelCopyWith on ChatRequestModel {
  ChatRequestModel copyWith({
    PerplexityModel? model,
    List<MessageModel>? messages,
    bool? stream,
    int? maxTokens,
    double? temperature,
    double? topP,
    List<String>? searchDomainFilter,
    bool? returnImages,
    bool? returnRelatedQuestions,
    String? searchRecencyFilter,
    int? topK,
    double? presencePenalty,
    double? frequencyPenalty,
    Map<String, dynamic>? responseFormat,
    Map<String, dynamic>? webSearchOptions,
  }) {
    return ChatRequestModel(
      model: model ?? this.model,
      messages: messages ?? this.messages,
      stream: stream ?? this.stream,
      maxTokens: maxTokens ?? this.maxTokens,
      temperature: temperature ?? this.temperature,
      topP: topP ?? this.topP,
      searchDomainFilter: searchDomainFilter ?? this.searchDomainFilter,
      returnImages: returnImages ?? this.returnImages,
      returnRelatedQuestions:
          returnRelatedQuestions ?? this.returnRelatedQuestions,
      searchRecencyFilter:
          searchRecencyFilter ?? this.searchRecencyFilter,
      topK: topK ?? this.topK,
      presencePenalty: presencePenalty ?? this.presencePenalty,
      frequencyPenalty: frequencyPenalty ?? this.frequencyPenalty,
      responseFormat: responseFormat ?? this.responseFormat,
      webSearchOptions: webSearchOptions ?? this.webSearchOptions,
    );
  }
}

