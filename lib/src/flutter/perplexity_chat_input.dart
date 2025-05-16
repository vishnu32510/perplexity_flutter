import 'package:flutter/material.dart';
import 'package:perplexity_dart/perplexity_dart.dart';

class PerplexityChatInput extends StatefulWidget {
  final InputDecoration? decoration;
  final bool showStreamToggle;
  final String submitLabel;

  const PerplexityChatInput({
    super.key,
    this.decoration,
    this.showStreamToggle = true,
    this.submitLabel = "Send",
  });

  @override
  State<PerplexityChatInput> createState() => _PerplexityChatInputState();
}

class _PerplexityChatInputState extends State<PerplexityChatInput> {
  final controller = TextEditingController();
  bool stream = true;

  void _submitPrompt() {
    final prompt = controller.text.trim();
    if (prompt.isEmpty) return;

    PerplexityChatController.of(context).submit(
      requestModel: ChatRequestModel.defaultRequest(model: PerplexityModel.sonar, prompt: prompt),
      stream: stream,
    );

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
              const Spacer(),
            ],
            ElevatedButton(
              onPressed: _submitPrompt,
              child: Text(widget.submitLabel),
            )
          ],
        )
      ],
    );
  }
}
