import "dart:convert";

import "package:chat_gpt/app/models/message_model.dart";

class AnswerModel {
  final String id;
  final String object;
  final int created;
  final String model;
  final UsageModel usage;
  final List<ChoiceModel> choices;

  AnswerModel({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.usage,
    required this.choices
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
    "id": this.id,
    "object": this.object,
    "created": this.created,
    "model": this.model,
    "usage": this.usage,
    "choices": this.choices
  };

  factory AnswerModel.fromMap(Map<String, dynamic> map) => AnswerModel(
    id: map["id"],
    object: map["object"],
    created: map["created"],
    model: map["model"],
    usage: UsageModel.fromMap(map["usage"]),
    choices: [ ...map["choices"].map((dynamic choice) => ChoiceModel.fromMap(choice)) ]
  );

  String toJson() => json.encode(this.toMap());
  factory AnswerModel.fromJson(String source) => AnswerModel.fromMap(json.decode(source));
}

class UsageModel {
  final int promptTokens;
  final int completionTokens;
  final int totalTokens;

  UsageModel({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
    "prompt_tokens": this.promptTokens,
    "completion_tokens": this.completionTokens,
    "total_tokens": this.totalTokens
  };

  factory UsageModel.fromMap(Map<String, dynamic> map) => UsageModel(
    promptTokens: map["prompt_tokens"],
    completionTokens: map["completion_tokens"],
    totalTokens: map["total_tokens"]
  );

  String toJson() => json.encode(this.toMap());
  factory UsageModel.fromJson(String source) => UsageModel.fromMap(json.decode(source));
}

class ChoiceModel {
  final MessageModel message;
  final String finishReason;
  final int index;

  ChoiceModel({
    required this.message,
    required this.finishReason,
    required this.index,
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
    "message": this.message,
    "finish_reason": this.finishReason,
    "index": this.index
  };

  factory ChoiceModel.fromMap(Map<String, dynamic> map) => ChoiceModel(
    message: MessageModel.fromMap(map["message"]),
    finishReason: map["finish_reason"],
    index: map["index"]
  );

  String toJson() => json.encode(this.toMap());
  factory ChoiceModel.fromJson(String source) => ChoiceModel.fromMap(json.decode(source));
}