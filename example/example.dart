import 'dart:io';
import 'package:perplexity_dart/perplexity_dart.dart';

void main() async {
  final client = PerplexityClient(
    apiKey: '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',
  );

  stdout.write("Enter your prompt: ");
  final prompt = stdin.readLineSync();

  stdout.write("Stream response? (y/n): ");
  final streamInput = stdin.readLineSync();
  final useStream = streamInput?.toLowerCase() == 'y';

  if (prompt == null || prompt.trim().isEmpty) {
    print("⚠️ No prompt entered. Exiting.");
    return;
  }

  try {
    if (useStream) {
      print("\n🔁 Streaming response:\n");
      final stream = client.streamChat(prompt: prompt.trim());
      await for (final chunk in stream) {
        stdout.write(chunk);
      }
      print("\n\n✅ Done.");
    } else {
      print("\n📥 Fetching full response...\n");
      final response = await client.sendMessage(prompt: prompt.trim());

      print("💬 Answer:\n${response.content}\n");

      if (response.citations.isNotEmpty) {
        print("🔗 Sources:");
        for (final source in response.citations) {
          print("- $source");
        }
      }
    }
  } catch (e) {
    print("\n❌ Error: $e");
  }
}
