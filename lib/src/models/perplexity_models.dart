class PerplexityModel {
  final String name;
  final int? contextLength;

  const PerplexityModel._(this.name, [this.contextLength]);

  static const PerplexityModel sonar = PerplexityModel._('sonar', 128000);
  static const PerplexityModel sonarPro =
      PerplexityModel._('sonar-pro', 200000);
  static const PerplexityModel sonarDeepResearch =
      PerplexityModel._('sonar-deep-research', 128000);
  static const PerplexityModel sonarReasoning =
      PerplexityModel._('sonar-reasoning', 128000);
  static const PerplexityModel sonarReasoningPro =
      PerplexityModel._('sonar-reasoning-pro', 128000);

  static const List<PerplexityModel> values = [
    sonar,
    sonarPro,
    sonarDeepResearch,
    sonarReasoning,
    sonarReasoningPro,
  ];

  factory PerplexityModel(String name) {
    try {
      return values.firstWhere((m) => m.name == name);
    } catch (_) {
      return PerplexityModel._(name);
    }
  }

  bool get isKnown => values.any((m) => m.name == name);
}
