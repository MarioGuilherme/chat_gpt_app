import "package:chat_gpt_app/app/core/extensions/enum_extension.dart";
import "package:chat_gpt_app/app/models/message_model.dart";
import "package:flutter/material.dart";

import "package:chat_gpt_app/app/core/ui/styles/colors_app.dart";
import "package:chat_gpt_app/app/core/ui/styles/text_styles.dart";

class MessageCard extends StatelessWidget {
  final MessageModel message;

  const MessageCard({
    super.key,
    required this.message
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: this.message.role.isUser
          ? Colors.transparent
          : ColorsApp.instance.secondary
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CircleAvatar(
                backgroundColor: this.message.role.isUser
                  ? const Color.fromRGBO(15, 163, 127, 1)
                  : ColorsApp.instance.tertiary,
                child: this.message.role.isUser
                  ? Text("TT", style: TextStyles.instance.textBold.copyWith(fontSize: 14))
                  : Image.asset("assets/icons/ai-icon.png", width: 16, height: 16)
              ),
              Visibility(
                visible: this.message.isError,
                child: Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                    child: Text("!", style: TextStyles.instance.textExtraBold.copyWith(fontFamily: TextStyles.lato, fontSize: 9, color: Colors.red))
                  )
                )
              )
            ]
          ),
          const SizedBox(width: 20),
          Flexible(
            child: this.message.isError
              ? Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(162, 69, 75, 0.25),
                    border: Border.all(color: const Color(0XFFBB4549), width: 1)
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    this.message.content,
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.visible,
                    style: TextStyles.instance.textRegular.copyWith(fontSize: 12)
                  )
                )
              : Text(
                  this.message.content,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.visible,
                  style: TextStyles.instance.textRegular.copyWith(fontSize: 14)
                )
          )
        ]
      )
    );
  }
}