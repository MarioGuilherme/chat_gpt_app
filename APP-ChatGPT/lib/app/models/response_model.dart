import "dart:convert";

class ResponseModel {
  final dynamic data;
  final bool isSuccess;

  ResponseModel({
    required this.data,
    this.isSuccess = true
  });

  Map<String, dynamic> toMap() {
    return {
      "data": data,
      "isSuccess": isSuccess
    };
  }

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(
      data: map["data"],
      isSuccess: map["isSuccess"] ?? false
    );
  }

  String toJson() => json.encode(this.toMap());

  factory ResponseModel.fromJson(String source) => ResponseModel.fromMap(json.decode(source));
}