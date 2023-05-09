import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_mobx/flutter_mobx.dart";
import "package:provider/provider.dart";

import "package:chat_gpt_app/app/core/ui/styles/colors_app.dart";
import "package:chat_gpt_app/app/core/ui/styles/text_styles.dart";
import "package:chat_gpt_app/app/pages/chat/controllers/chat_controller.dart";
import "package:chat_gpt_app/app/pages/chat/widgets/chat_gpt_app_card.dart";
import "package:chat_gpt_app/app/pages/chat/widgets/chat_gpt_appbar.dart";
import "package:chat_gpt_app/app/pages/chat/widgets/message_card.dart";
import "package:chat_gpt_app/app/pages/chat/widgets/warning_rich_text.dart";

class ChatPage extends StatelessWidget {
  final OutlineInputBorder _outlineInputBorder = const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent));
  final ScrollController _scrollController = ScrollController();
  final FocusNode _questionInputFocusNode = FocusNode();
  final TextEditingController _questionEC = TextEditingController();

  ChatPage({super.key});

  void _scrollToEnd() async => await this._scrollController.animateTo(
    this._scrollController.position.maxScrollExtent * 2,
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeOut
  );

  @override
  Widget build(BuildContext context) {
    final ChatController chatController = context.read<ChatController>();
    chatController.loadMessagesFromStorage();

    return Scaffold(
      backgroundColor: ColorsApp.instance.primary,
      appBar: ChatGPTAppBar(),
      body: SafeArea(
        child: Observer(
          builder: (_) => Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: this._scrollController,
                  child: Visibility(
                    visible: chatController.messages.isEmpty,
                    replacement: Column(children: chatController.messages.map((message) => MessageCard(message: message)).toList()),
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        Text("MADE CHAT", style: TextStyles.instance.textRegular.copyWith(fontSize: 26, fontFamily: TextStyles.lato)),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/icons/idea-icon.png", width: 24, height: 24),
                            const SizedBox(width: 15),
                            Text(
                              "Exemplos",
                              style: TextStyles.instance.textRegular.copyWith(
                                color: ColorsApp.instance.tertiary,
                                fontSize: 19,
                                fontFamily: TextStyles.lato
                              )
                            )
                          ]
                        ),
                        const SizedBox(height: 15),
                        ChatGPTAppCard.question(controller: this._questionEC, content: "“Cite todas as peças de William Shakespeare em ordem cronologica”"),
                        ChatGPTAppCard.question(controller: this._questionEC, content: "“Como fazer callback em javascript?”"),
                        ChatGPTAppCard.question(controller: this._questionEC, content: "“Me fale sobre a cidade de Lins, em SP”"),
                        ChatGPTAppCard.question(controller: this._questionEC, content: "“Faça um resumo de no maximo 500 linhas sobre o filme Pantera Negra: Wakanda Forever”"),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              "assets/icons/warning-icon.png",
                              width: 24,
                              height: 24,
                            ),
                            const SizedBox(width: 15),
                            Text(
                              "Limitações",
                              style: TextStyles.instance.textRegular.copyWith(
                                color: ColorsApp.instance.tertiary,
                                fontSize: 19,
                                fontFamily: TextStyles.lato
                              )
                            )
                          ]
                        ),
                        const SizedBox(height: 15),
                        const ChatGPTAppCard.limitation(content: "Não compartilhe dados confindênciais"),
                        const ChatGPTAppCard.limitation(content: "As respostas estão sujeitas a erros"),
                        const ChatGPTAppCard.limitation(content: "Tempo de espera pode aumentar de acordo com a demanda de acesso"),
                      ]
                    )
                  )
                )
              ),
              Container(
                height: kIsWeb ? 80 : 100,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color.fromRGBO(68, 70, 83, 1)))),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              selectionControls: MaterialTextSelectionControls(),
                              controller: this._questionEC,
                              maxLines: null,
                              focusNode: this._questionInputFocusNode,
                              textInputAction: TextInputAction.newline,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                suffixStyle: const TextStyle(color: Colors.white),
                                suffixIcon: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Material(
                                    color: ColorsApp.instance.secondary,
                                    child: InkWell(
                                      onTap: chatController.isWaitingResponse
                                        ? null
                                        : () async {
                                          String question = this._questionEC.text.trim();
                                          if (question.isEmpty) return;
                                          this._questionEC.text = "";
                                          await chatController.newQuestion(question);
                                          this._scrollToEnd();
                                        },
                                      child: Ink(child: const Icon(Icons.send, color: Colors.white))
                                    )
                                  )
                                ),
                                focusedBorder: this._outlineInputBorder,
                                disabledBorder: this._outlineInputBorder,
                                enabledBorder: this._outlineInputBorder,
                                fillColor: ColorsApp.instance.secondary
                              )
                            )
                          ),
                          Visibility(
                            visible: chatController.messages.isNotEmpty,
                            child: SizedBox(
                              width: 60,
                              child: Material(
                                color: ColorsApp.instance.primary,
                                child: InkWell(
                                  child: Ink(
                                    child: IconButton(
                                      icon: const Icon(Icons.refresh, color: Colors.white),
                                      onPressed: chatController.isWaitingResponse
                                        ? null
                                        : () async {
                                          await chatController.retryLastQuestion();
                                          this._scrollToEnd();
                                        }
                                    )
                                  )
                                )
                              )
                            )
                          )
                        ]
                      ),
                      const SizedBox(height: 4),
                      const WarningRichText()
                    ]
                  )
                )
              )
            ]
          )
        )
      )
    );
  }
}