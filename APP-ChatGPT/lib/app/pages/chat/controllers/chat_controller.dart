import "dart:developer";

import "package:mobx/mobx.dart";

import "package:chat_gpt_app/app/models/message_model.dart";
import "package:chat_gpt_app/app/models/role.dart";
import "package:chat_gpt_app/app/repositories/chat/chat_repository.dart";
import "package:chat_gpt_app/app/repositories/storage/storage_repository.dart";

part "chat_controller.g.dart";

// ignore: library_private_types_in_public_api
class ChatController = _ChatController with _$ChatController;

abstract class _ChatController with Store {
  final ChatRepository _chatRepository;
  final StorageRepository _storageRepository;

  _ChatController(this._chatRepository, this._storageRepository);

  @observable
  ObservableList<MessageModel> messages = ObservableList<MessageModel>();

  @observable
  bool isWaitingResponse = false;

  @action
  Future<void> loadMessagesFromStorage() async => this.messages.addAll(await this._storageRepository.getAllMessages());

  @action
  Future<void> clearMessages() async {
    await this._storageRepository.saveQuestions([]);
    this.messages.clear();
  }

  @action
  Future<void> retryLastQuestion() async {
    try {
      this.messages.last = MessageModel(
        content: "Recriando resposta...",
        role: Role.system
      );
      this.isWaitingResponse = true;
      this.messages.last = await this._chatRepository.makeAQuestion([...this.messages.where((m) => m.role != Role.system)]);
    } on Exception catch (e, s) {
      log("Erro ao fazer pergunta ao CHAT GPT", error: e, stackTrace: s);
      this.messages.last = MessageModel(
        content: "Algo deu errado ao gerar resposta. Tente recriar a resposta, caso o problema persista, nos contate.",
        role: Role.system,
        isError: true
      );
    } finally {
      await this._storageRepository.saveQuestions(this.messages);
      this.isWaitingResponse = false;
    }
  }

  @action
  Future<void> newQuestion(String question) async {
    try {
      this.messages.addAll([
        MessageModel(
          content: question,
          role: Role.user
        ),
        MessageModel(
          content: "Processando",
          role: Role.system
        )
      ]);
      this.isWaitingResponse = true;
      this.messages.last = await this._chatRepository.makeAQuestion([...this.messages.where((m) => m.role != Role.system)]);
    } on Exception catch (e, s) {
      log("Erro ao fazer pergunta ao CHAT GPT", error: e, stackTrace: s);
      this.messages.last = MessageModel(
        content: "Algo deu errado ao gerar resposta. Tente recriar a resposta, caso o problema persista, nos contate.",
        role: Role.system,
        isError: true
      );
    } finally {
      await this._storageRepository.saveQuestions(this.messages);
      this.isWaitingResponse = false;
    }
  }
}