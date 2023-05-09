// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChatController on _ChatController, Store {
  late final _$messagesAtom =
      Atom(name: '_ChatController.messages', context: context);

  @override
  ObservableList<MessageModel> get messages {
    _$messagesAtom.reportRead();
    return super.messages;
  }

  @override
  set messages(ObservableList<MessageModel> value) {
    _$messagesAtom.reportWrite(value, super.messages, () {
      super.messages = value;
    });
  }

  late final _$isWaitingResponseAtom =
      Atom(name: '_ChatController.isWaitingResponse', context: context);

  @override
  bool get isWaitingResponse {
    _$isWaitingResponseAtom.reportRead();
    return super.isWaitingResponse;
  }

  @override
  set isWaitingResponse(bool value) {
    _$isWaitingResponseAtom.reportWrite(value, super.isWaitingResponse, () {
      super.isWaitingResponse = value;
    });
  }

  late final _$loadMessagesFromStorageAsyncAction =
      AsyncAction('_ChatController.loadMessagesFromStorage', context: context);

  @override
  Future<void> loadMessagesFromStorage() {
    return _$loadMessagesFromStorageAsyncAction
        .run(() => super.loadMessagesFromStorage());
  }

  late final _$clearMessagesAsyncAction =
      AsyncAction('_ChatController.clearMessages', context: context);

  @override
  Future<void> clearMessages() {
    return _$clearMessagesAsyncAction.run(() => super.clearMessages());
  }

  late final _$retryLastQuestionAsyncAction =
      AsyncAction('_ChatController.retryLastQuestion', context: context);

  @override
  Future<void> retryLastQuestion() {
    return _$retryLastQuestionAsyncAction.run(() => super.retryLastQuestion());
  }

  late final _$newQuestionAsyncAction =
      AsyncAction('_ChatController.newQuestion', context: context);

  @override
  Future<void> newQuestion(String question) {
    return _$newQuestionAsyncAction.run(() => super.newQuestion(question));
  }

  @override
  String toString() {
    return '''
messages: ${messages},
isWaitingResponse: ${isWaitingResponse}
    ''';
  }
}
