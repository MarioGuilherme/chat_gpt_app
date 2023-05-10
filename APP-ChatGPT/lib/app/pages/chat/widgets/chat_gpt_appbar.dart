import "package:flutter/material.dart";
import "package:flutter_mobx/flutter_mobx.dart";
import "package:provider/provider.dart";

import "package:chat_gpt_app/app/core/ui/styles/colors_app.dart";
import "package:chat_gpt_app/app/core/ui/styles/text_styles.dart";
import "package:chat_gpt_app/app/pages/chat/controllers/chat_controller.dart";

class ChatGPTAppBar extends AppBar {
  ChatGPTAppBar({super.key}) : super(
    shape: const Border(bottom: BorderSide(width: 1, color: Color.fromRGBO(68, 70, 83, 1))),
    backgroundColor: ColorsApp.instance.primary,
    actions: [
      Builder(
        builder: (context) {
          final ChatController chatController = context.read<ChatController>();
          return Observer(
            builder: (_) => IconButton(
              icon: const Icon(Icons.restore_from_trash, color: Colors.white),
              onPressed: chatController.isWaitingResponse
                ? null
                : () => chatController.clearMessages()
            )
          );
        }
      )
    ],
    title: Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
      decoration: BoxDecoration(
        color: ColorsApp.instance.tertiary,
        borderRadius: BorderRadius.circular(5)
      ),
      child: Text("Bem vindo!", style: TextStyles.instance.textMedium.copyWith(fontSize: 14, color: ColorsApp.instance.primary))
    )
  );
}