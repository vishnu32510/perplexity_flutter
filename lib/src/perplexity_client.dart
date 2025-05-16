import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/model.dart';

class PerplexityClient {
  final String apiKey;
  final String baseUrl;

  PerplexityClient({required this.apiKey, this.baseUrl = 'https://api.perplexity.ai'});

  /// Non-streaming response
  Future<ChatResponse> sendMessage({required ChatRequestModel requestModel}) async {
    final request = requestModel.copyWith(stream: false);

    final response = await http.post(
      Uri.parse('$baseUrl/chat/completions'),
      headers: {'Authorization': 'Bearer $apiKey', 'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      return ChatResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get response: ${response.statusCode} - ${response.body}');
    }
  }

  /// Streaming response
  Stream<String> streamChat({required ChatRequestModel requestModel}) async* {
    final request = requestModel.copyWith(stream: true);

    final uri = Uri.parse('$baseUrl/chat/completions');
    final client = http.Client();

    final req = http.Request("POST", uri)
      ..headers.addAll({'Authorization': 'Bearer $apiKey', 'Content-Type': 'application/json'})
      ..body = jsonEncode(request.toJson());

    final response = await client.send(req);

    if (response.statusCode != 200) {
      throw Exception('Failed to connect: ${response.statusCode}');
    }

    final lines = response.stream.transform(utf8.decoder).transform(const LineSplitter());

    await for (final line in lines) {
      if (line.trim().isEmpty || line == 'data: [DONE]') continue;

      final jsonLine = line.replaceFirst('data: ', '');
      final jsonData = jsonDecode(jsonLine);
      final delta = jsonData['choices'][0]['delta'];
      final chunk = delta['content'] ?? '';
      yield chunk;
    }

    client.close();
  }
}
