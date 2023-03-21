import "dart:developer";

import "package:chat_gpt/app/core/ui/styles/colors_app.dart";
import "package:chat_gpt/app/core/ui/styles/text_styles.dart";
import "package:chat_gpt/app/core/ui/utils/size_extensions.dart";
import "package:chat_gpt/app/models/answer_model.dart";
import "package:chat_gpt/app/models/message_model.dart";
import "package:chat_gpt/app/pages/chat/widgets/message_card.dart";
import "package:chat_gpt/app/pages/chat/widgets/warning_card.dart";
import "package:chat_gpt/app/repositories/chat/chat_repository.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _questionEC = TextEditingController();
  bool _startedChat = false;
  bool _isWaitingResponse = false;
  final _questionInputFocusNode = FocusNode();
  final GlobalKey _columMessages = GlobalKey();
  final _controllerChatScroll = ScrollController();
  final List<MessageModel> _messages = <MessageModel>[];

  @override
  void dispose() {
    this._controllerChatScroll.dispose();
    super.dispose();
  }

  double _getMyWidgetHeight() {
    final RenderBox? renderBox = _columMessages.currentContext?.findRenderObject() as RenderBox?;
    return renderBox!.size.height;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.instance.primary,
      appBar: AppBar(
        elevation: 1,
        shadowColor: const Color.fromRGBO(116, 118, 130, 1),
        backgroundColor: ColorsApp.instance.primary,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
          decoration: BoxDecoration(
            color: ColorsApp.instance.tertiary,
            borderRadius: BorderRadius.circular(5)
          ),
          child: Text("Bem vindo!", style: TextStyles.instance.textSemiBold.copyWith(fontSize: 14, color: ColorsApp.instance.primary))
        )
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                controller: this._controllerChatScroll,
                child: Column(
                  key: this._columMessages,
                  children: <Widget>[
                    Visibility(
                      visible: !this._startedChat,
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: <Widget>[
                            const SizedBox(height: 21),
                            Text(
                              "MADE CHAT",
                              style: TextStyles.instance.textBold.copyWith(fontSize: 26, fontFamily: TextStyles.lato)
                            ),
                            const SizedBox(height: 35),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset("assets/icons/light-icon.png", width: 24, height: 24),
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
                            const SizedBox(height: 23.5),
                            WarningCard(questionEC: this._questionEC, content: "“Cite todas as peças de William Shakespeare em ordem cronologica”"),
                            WarningCard(questionEC: this._questionEC, content: "“Como fazer callback em javascript?”"),
                            WarningCard(questionEC: this._questionEC, content: "“Me fale sobre a cidade de Lins, em SP”"),
                            WarningCard(questionEC: this._questionEC, content: "“Faça um resumo de no maximo 500 linhas sobre o filme Pantera Negra: Wakanda Forever”"),
                            const SizedBox(height: 45),
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
                            SizedBox(
                              width: context.screenWidth,
                              child: Column(
                                children: const <Widget>[
                                  SizedBox(height: 23.5),
                                  WarningCard(content: "Não compartilhe dados confindências"),
                                  WarningCard(content: "As respostas estão sujeitas a erros"),
                                  WarningCard(content: "Tempo de espera pode aumentar de acordo com a demanda de acesso")
                                ]
                              )
                            )
                          ]
                        )
                      )
                    ),
                    Visibility(
                      visible: this._startedChat,
                      child: Column(
                        children: this._messages.map((MessageModel answer) => MessageCard(answer: answer)).toList()
                      )
                    )
                  ]
                )
              )
            ),
            Container(
              padding: const EdgeInsets.only(left: 9, right: 9, top: 9),
              height: context.percentHeigth(.175),
              decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.white, width: 1))),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        Flexible(
                          flex: 10,
                          child: TextField(
                            focusNode: this._questionInputFocusNode,
                            controller: this._questionEC,
                            style: const TextStyle(color: Colors.white),
                            maxLines: null,
                            textInputAction: TextInputAction.newline,
                            decoration: InputDecoration(
                              suffixStyle: const TextStyle(color: Colors.white),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.send),
                                color: Colors.white,
                                onPressed: this._isWaitingResponse
                                  ? null
                                  : () async {
                                    this._questionInputFocusNode.unfocus();
                                    String question = this._questionEC.text.trim();
                                    if (question.isEmpty) return;
                                    this._questionEC.text = "";

                                    try {
                                      setState(() {
                                        this._isWaitingResponse = true;
                                        this._startedChat = true;
                                        this._messages.addAll([
                                          MessageModel(
                                            content: question,
                                            isMyMessage: true
                                          ),
                                          MessageModel(
                                            content: "Processando",
                                            isMyMessage: false
                                          )
                                        ]);
                                      });
                                      this._controllerChatScroll.animateTo(
                                        this._getMyWidgetHeight(),
                                        duration: const Duration(seconds: 1),
                                        curve: Curves.easeInOut,
                                      );
                          
                                      ChatRepository repository = Provider.of<ChatRepository>(context, listen: false);
                                      AnswerModel answer = await repository.askAQuestion(question);
                                      setState(() {
                                        this._messages.last = MessageModel(
                                          content: answer.choices.first.message.content.trim(),
                                          isMyMessage: false
                                        );
                                      });
                                      this._controllerChatScroll.animateTo(
                                        this._getMyWidgetHeight(),
                                        duration: const Duration(seconds: 1),
                                        curve: Curves.easeInOut,
                                      );
                                      log(answer.choices.first.message.content);
                                    } on Exception catch (e, s) {
                                      log("Erro ao fazer pergunta ao CHAT GPT", error: e, stackTrace: s);
                                      setState(() {
                                        this._messages.last = MessageModel(
                                          content: "Algo deu errado ao gerar resposta. Tente regenerar a resposta, caso o problema persista, nos contate.",
                                          isMyMessage: false,
                                          isError: true
                                        );
                                      });
                                      this._controllerChatScroll.animateTo(
                                        this._getMyWidgetHeight(),
                                        duration: const Duration(seconds: 1),
                                        curve: Curves.easeInOut,
                                      );
                                    }
                                    setState(() => this._isWaitingResponse = false);
                                  }
                              ),
                              filled: true,
                              focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                              disabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                              enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                              fillColor: ColorsApp.instance.secondary,
                              contentPadding: const EdgeInsets.all(18)
                            )
                          )
                        ),
                        Visibility(
                          visible: this._startedChat,
                          child: Expanded(
                            flex: 2,
                            child: IconButton(
                              icon: const Icon(Icons.refresh, color: Colors.white),
                              onPressed: this._isWaitingResponse
                                ? null
                                : () async {
                                  MessageModel lastQuestion = this._messages[this._messages.length - 2];
                          
                                  try {
                                    setState(() {
                                      this._isWaitingResponse = true;
                                      this._messages.last = MessageModel(
                                        content: "Recriando resposta...",
                                        isMyMessage: false
                                      );
                                    });
                                    this._controllerChatScroll.animateTo(
                                      this._getMyWidgetHeight(),
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.easeInOut,
                                    );
                          
                                    ChatRepository repository = Provider.of<ChatRepository>(context, listen: false);
                                    AnswerModel answer = await repository.askAQuestion(lastQuestion.content);
                          
                                    setState(() {
                                      this._messages.last = MessageModel(
                                        content: answer.choices.first.message.content.trim(),
                                        isMyMessage: false
                                      );
                                    });
                                    this._controllerChatScroll.animateTo(
                                      this._getMyWidgetHeight(),
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.easeInOut,
                                    );
                          
                                    log(answer.choices.first.message.content);
                                  } on Exception catch (e, s) {
                                    log("Erro ao fazer pergunta ao CHAT GPT", error: e, stackTrace: s);
                                    setState(() {
                                      this._messages.last = MessageModel(
                                        content: "Algo deu errado ao gerar resposta. Tente regenerar a resposta, caso o problema persista, nos contate.",
                                        isMyMessage: false,
                                        isError: true
                                      );
                                    });
                                    this._controllerChatScroll.animateTo(
                                      this._getMyWidgetHeight(),
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                  setState(() => this._isWaitingResponse = false);
                                }
                            )
                          )
                        )
                      ]
                    ),
                    const SizedBox(height: 4),
                    RichText(
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
                    ),
                    const SizedBox(height: 4)
                  ]
                )
              )
            )
          ]
        )
      )
    );
  }
}