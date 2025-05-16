import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perplexity_flutter/perplexity_dart.dart';


class ChatWrapperWidget extends StatelessWidget {
  final String apiKey;
  final Widget child;
  final PerplexityModel model;

  const ChatWrapperWidget({
    super.key,
    required this.apiKey,
    required this.child,
    this.model = PerplexityModel.sonar,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatBloc(client: PerplexityClient(apiKey: apiKey)),
      child: child,
    );
  }
}
