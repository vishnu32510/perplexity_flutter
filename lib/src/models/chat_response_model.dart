class ChatResponse {
  final String content;
  final List<String> citations;

  ChatResponse({required this.content, required this.citations});

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    final choices = json['choices'] as List<dynamic>;
    final content = choices.first['message']['content'] ?? '';
    final citations = List<String>.from(json['citations'] ?? []);
    return ChatResponse(content: content, citations: citations);
  }
}
