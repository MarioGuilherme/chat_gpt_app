import "package:flutter/material.dart";

import "package:chat_gpt_app/app/core/provider/application_binding.dart";
import "package:chat_gpt_app/app/core/ui/theme/theme_config.dart";
import "package:chat_gpt_app/app/pages/chat/chat_router.dart";

class ChatGPTApp extends StatelessWidget {
  const ChatGPTApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ApplicationBinding(
      child: MaterialApp(
        title: "Chat GPT",
        theme: ThemeConfig.theme,
        debugShowCheckedModeBanner: false,
        routes: <String, Widget Function(BuildContext)>{
          "/": (BuildContext context) => ChatRouter.page
        }
      )
    );
  }
}