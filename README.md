# perplexity_dart

[![pub package](https://img.shields.io/pub/v/perplexity_dart.svg)](https://pub.dev/packages/perplexity_dart)
[![License: MIT](https://img.shields.io/badge/license-MIT-yellow.svg)](LICENSE)

**Perplexity Dart SDK** is a lightweight and type-safe Dart client for interacting with [Perplexity.ai](https://www.perplexity.ai)'s `chat/completions` API.  
It supports both streaming and non-streaming responses, flexible model switching (e.g., `sonar`, `sonar-pro`, etc.), and is designed to work with Dart CLI and Flutter apps.

---

## ✨ Features

- 🔁 Streamed and full chat completion support
- 🎯 Switch between models with known context lengths
- 💬 Chat roles: `system`, `user`, `assistant`, `tool`
- 🧱 BLoC integration ready
- 🖼️ *Coming soon:* Image input via base64 or HTTPS URL

---

## 🚀 Getting Started

Add the SDK to your project:

```yaml
dependencies:
  perplexity_dart: ^0.0.1
```

Import the SDK in your Dart code:

```dart
import 'package:perplexity_dart/perplexity_dart.dart';
```

Initialize the client with your API key:

```dart
final client = PerplexityClient(
  apiKey: 'your-api-key',
);
```

Send a chat request:

```dart
final response = await client.sendMessage(
  prompt: 'Hello, how are you?',
  model: PerplexityModel.sonarPro,
);
```

Stream a chat response:

```dart
final stream = client.streamChat(
  prompt: 'Hello, how are you?',
  model: PerplexityModel.sonarPro,
);

await for (final chunk in stream) {
  print(chunk);
}
```