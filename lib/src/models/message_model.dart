class MessageModel {
  final MessageRole role;
  final String content;

  MessageModel({required this.role, required this.content});

  Map<String, dynamic> toJson() => {
        'role': role.name,
        'content': content,
      };
}

class MessageRole {
  final String name;

  const MessageRole._(this.name);

  static const MessageRole system = MessageRole._('system');
  static const MessageRole user = MessageRole._('user');
  static const MessageRole assistant = MessageRole._('assistant');
  static const MessageRole tool = MessageRole._('tool');

  static const List<MessageRole> values = [system, user, assistant, tool];

  /// Allows dynamic/future roles safely
  factory MessageRole.dynamic(String roleName) {
    return values.firstWhere(
      (role) => role.name == roleName,
      orElse: () => MessageRole._(roleName),
    );
  }

  @override
  String toString() => name;
}
