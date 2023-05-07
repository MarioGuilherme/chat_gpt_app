import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "package:chat_gpt_app/app/pages/chat/chat_page.dart";
import "package:chat_gpt_app/app/pages/chat/controllers/chat_controller.dart";

class ChatRouter {
  ChatRouter._();

  static Widget get page => MultiProvider(
    providers: [
      Provider<ChatController>(create: (BuildContext context) => ChatController(context.read(), context.read()))
    ],
    child: ChatPage()
  );
}