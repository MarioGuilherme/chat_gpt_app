import "package:flutter/material.dart";

import "package:chat_gpt/app/core/ui/styles/colors_app.dart";
import "package:chat_gpt/app/core/ui/styles/text_styles.dart";

class WarningCard extends StatelessWidget {
  final String content;
  final TextEditingController? questionEC;

  const WarningCard({
    required this.content,
    super.key,
    this.questionEC,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.questionEC == null
        ? null
        : () => this.questionEC!.text = this.content.replaceAll(RegExp(r"[“”]"), ""),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 23, vertical: 7.5),
        decoration: BoxDecoration(
          color: ColorsApp.instance.secondary,
          borderRadius: BorderRadius.circular(5)
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 26),
        child: Text(
          this.content,
          textAlign: TextAlign.center,
          style: TextStyles.instance.textSemiBold.copyWith(color: Colors.white, fontSize: 14)
        )
      ),
    );
  }
}