import "package:flutter/material.dart";
import "package:flutter/services.dart";

import "package:chat_gpt_app/app/chat_gpt_app.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]).then((_) => runApp(const ChatGPTApp()));
}