import "package:flutter/material.dart";

import "package:chat_gpt_app/app/core/ui/styles/text_styles.dart";

class WarningRichText extends StatelessWidget {
  const WarningRichText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "Estamos utilizando a API ",
        style: TextStyles.instance.textRegular.copyWith(fontSize: 10, color: const Color(0xFFD2D2D2)),
        children: <TextSpan>[
          TextSpan(
            text: "OpenAI Completitions",
            style: TextStyles.instance.textRegular.copyWith(
              fontSize: 10,
              color: const Color(0xFFD2D2D2),
              decorationThickness: 3,
              decoration: TextDecoration.underline
            )
          ),
          TextSpan(
            text: ". Todas as interações estão sendo vinculadas ao ChatGPT e sua mantedora oficial, a OpenAI",
            style: TextStyles.instance.textRegular.copyWith(fontSize: 10, color: const Color(0xFFD2D2D2))
          )
        ]
      )
    );
  }
}