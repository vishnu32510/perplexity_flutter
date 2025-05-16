import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perplexity_flutter/perplexity_flutter.dart';

class PerplexityChatController {
  final BuildContext context;

  PerplexityChatController._(this.context);

  static PerplexityChatController of(BuildContext context) {
    return PerplexityChatController._(context);
  }

  void submit({required ChatRequestModel requestModel, bool stream = true}) {
    final bloc = context.read<ChatBloc>();
    bloc.add(ChatPromptSubmitted(requestModel, stream: stream));
  }
}
