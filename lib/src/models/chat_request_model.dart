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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      'model': model.name,
      'messages': messages.map((m) => m.toJson()).toList(),
    };

    if (maxTokens != null) json['max_tokens'] = maxTokens;
    if (temperature != null) json['temperature'] = temperature;
    if (topP != null) json['top_p'] = topP;
    if (searchDomainFilter != null) json['search_domain_filter'] = searchDomainFilter;
    if (returnImages != null) json['return_images'] = returnImages;
    if (returnRelatedQuestions != null) json['return_related_questions'] = returnRelatedQuestions;
    if (searchRecencyFilter != null) json['search_recency_filter'] = searchRecencyFilter;
    if (topK != null) json['top_k'] = topK;
    if (stream != null) json['stream'] = stream;
    if (presencePenalty != null) json['presence_penalty'] = presencePenalty;
    if (frequencyPenalty != null) json['frequency_penalty'] = frequencyPenalty;
    if (responseFormat != null) json['response_format'] = responseFormat;
    if (webSearchOptions != null) json['web_search_options'] = webSearchOptions;

    return json;
  }
}
