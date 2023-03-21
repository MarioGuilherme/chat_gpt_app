import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "package:chat_gpt/app/core/rest/custom_dio.dart";

class ApplicationBinding extends StatelessWidget {
  final Widget child;

  const ApplicationBinding({
    required this.child,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <Provider<Dio>>[
        Provider<Dio>(create: (BuildContext context) => CustomDio())
      ],
      child: this.child
    );
  }
}