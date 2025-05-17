## 2.0.0

* Improved code quality to meet pub.dev standards
* Great structure, splitting the project into [`perplexity_dart`](https://pub.dev/packages/perplexity_dart) (pure API logic) and `perplexity_flutter` (UI widgets built on top) follows best practices in package architecture
* This separation of concerns keeps [`perplexity_dart`](https://pub.dev/packages/perplexity_dart) lightweight and testable for any Dart app (e.g., CLI, server)
* Makes `perplexity_flutter` plug-and-play for Flutter devs who want quick UI integration

## 1.0.5

* Fixed issue tracker URL in pubspec.yaml
* Improved package metadata

## 1.0.4

* Updated http package dependency to ^1.0.0 for better compatibility
* Fixed linting issues in chat_request_model.dart
* Improved code quality to meet pub.dev standards

## 1.0.3

* Improved documentation

## 1.0.2

* Updated http package dependency to ^1.0.0 for better compatibility
* Fixed linting issues in chat_request_model.dart
* Improved code quality to meet pub.dev standards
* Fixed minor bugs
* Improved documentation

## 1.0.1

* Added additional features
* Bug fixes and performance improvements

## 1.0.0

* Initial release of the Perplexity Flutter SDK
* Support for streaming and non-streaming chat completions
* Multiple Perplexity models support (sonar, sonar-pro, etc.)
* BLoC integration for Flutter apps
* Chat roles: system, user, assistant, tool
* Ready-to-use Flutter widgets for chat UI
