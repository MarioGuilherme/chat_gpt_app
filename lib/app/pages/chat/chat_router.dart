import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "package:chat_gpt/app/pages/chat/chat_page.dart";
import "package:chat_gpt/app/repositories/chat/chat_repository.dart";
import "package:chat_gpt/app/repositories/chat/chat_repository_imp.dart";

class ChatRouter {
  ChatRouter._();

  static Widget get page => MultiProvider(
    providers: <Provider<ChatRepository>>[
      Provider<ChatRepository>(create: (BuildContext context) => ChatRepositoryImpl(dio: context.read()))
    ],
    child: const ChatPage()
  );
}