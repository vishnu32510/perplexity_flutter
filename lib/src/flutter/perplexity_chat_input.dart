import 'package:flutter/material.dart';
import 'package:perplexity_dart/perplexity_dart.dart';
import 'package:perplexity_flutter/src/flutter/perplexity_chat_controller.dart';

/// A widget for inputting prompts to send to the Perplexity API.
class PerplexityChatInput extends StatefulWidget {
  /// Optional decoration for the text input field.
  final InputDecoration? decoration;

  /// Whether to show the streaming toggle switch.
  final bool showStreamToggle;

  /// Label text for the submit button.
  final String submitLabel;

  /// Whether to enable image input support.
  final bool enableImageInput;

  /// Whether to enable search features.
  final bool enableSearch;

  /// Creates a new chat input widget.
  const PerplexityChatInput({
    super.key,
    this.decoration,
    this.showStreamToggle = true,
    this.submitLabel = "Send",
    this.enableImageInput = false,
    this.enableSearch = false,
  });

  @override
  State<PerplexityChatInput> createState() => _PerplexityChatInputState();
}

class _PerplexityChatInputState extends State<PerplexityChatInput> {
  final controller = TextEditingController();
  bool stream = true;
  bool useImage = false;
  bool useSearch = false;
  List<String>? searchDomains;
  String? recencyFilter;

  void _submitPrompt() {
    final prompt = controller.text.trim();
    if (prompt.isEmpty) return;

    final requestModel = ChatRequestModel.defaultRequest(
      model: PerplexityModel.sonar,
      prompt: prompt,
    );

    if (useImage && widget.enableImageInput) {
      PerplexityChatController.of(context).submitWithImage(
        requestModel: requestModel,
        stream: stream,
      );
    } else if (useSearch && widget.enableSearch) {
      PerplexityChatController.of(context).submitWithSearch(
        requestModel: requestModel,
        stream: stream,
        searchDomains: searchDomains,
        recencyFilter: recencyFilter,
      );
    } else {
      PerplexityChatController.of(context).submit(
        requestModel: requestModel,
        stream: stream,
      );
    }

    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          decoration: widget.decoration ??
              const InputDecoration(labelText: 'Enter your prompt'),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            if (widget.showStreamToggle) ...[
              const Text("Stream:"),
              Switch(
                value: stream,
                onChanged: (val) => setState(() => stream = val),
              ),
            ],
            if (widget.enableImageInput) ...[
              const Text("Image:"),
              Switch(
                value: useImage,
                onChanged: (val) => setState(() => useImage = val),
              ),
            ],
            if (widget.enableSearch) ...[
              const Text("Search:"),
              Switch(
                value: useSearch,
                onChanged: (val) => setState(() => useSearch = val),
              ),
            ],
            const Spacer(),
            ElevatedButton(
              onPressed: _submitPrompt,
              child: Text(widget.submitLabel),
            ),
          ],
        ),
        if (useSearch && widget.enableSearch) ...[
          const SizedBox(height: 8),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Search Domains (comma-separated)',
            ),
            onChanged: (value) {
              setState(() {
                searchDomains = value.split(',').map((e) => e.trim()).toList();
              });
            },
          ),
          DropdownButton<String>(
            value: recencyFilter,
            hint: const Text('Recency Filter'),
            items: ['hour', 'day', 'week', 'month', 'year']
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (value) {
              setState(() {
                recencyFilter = value;
              });
            },
          ),
        ],
      ],
    );
  }
}