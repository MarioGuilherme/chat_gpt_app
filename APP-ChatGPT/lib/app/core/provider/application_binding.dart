import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "package:chat_gpt_app/app/core/http/http_client.dart";
import "package:chat_gpt_app/app/core/http/http_client_impl.dart";
import "package:chat_gpt_app/app/repositories/chat/chat_repository.dart";
import "package:chat_gpt_app/app/repositories/chat/chat_repository_impl.dart";
import "package:chat_gpt_app/app/repositories/storage/storage_repository.dart";
import "package:chat_gpt_app/app/repositories/storage/storage_repository_impl.dart";

class ApplicationBinding extends StatelessWidget {
  final Widget child;

  const ApplicationBinding({
    required this.child,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <InheritedProvider>[
        Provider<HttpClient>(create: (BuildContext context) => HttpClientImpl(dio: Dio())),
        Provider<ChatRepository>(create: (BuildContext context) => ChatRepositoryImpl(httpClient: context.read())),
        Provider<StorageRepository>(create: (BuildContext context) => StorageRepositoryImpl())
      ],
      child: this.child
    );
  }
}