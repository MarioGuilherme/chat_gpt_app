import "package:flutter/material.dart";

import "package:chat_gpt_app/app/core/ui/styles/colors_app.dart";
import "package:chat_gpt_app/app/core/ui/styles/text_styles.dart";

class ChatGPTAppCard extends StatelessWidget {
  final TextEditingController? controller;
  final String content;

  const ChatGPTAppCard.question({
    super.key,
    required this.content,
    required this.controller
  });

  const ChatGPTAppCard.limitation({
    super.key,
    required this.content
  }) : this.controller = null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 7.5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Material(
          color: Theme.of(context).colorScheme.primary,
          child: InkWell(
            onTap: this.controller != null
              ? () => this.controller!.text = this.content.replaceAll(RegExp(r"[“”]"), "")
              : null,
            child: Ink(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 26),
              decoration: BoxDecoration(color: ColorsApp.instance.secondary),
              child: Text(
                this.content,
                textAlign: TextAlign.center,
                style: TextStyles.instance.textSemiBold.copyWith(color: Colors.white, fontSize: 14)
              )
            )
          )
        )
      )
    );
  }
}