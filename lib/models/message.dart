import 'package:scholar_chat/constints.dart';

class Message {
  final String message;

  Message({required this.message});

  factory Message.fromJson(jsonData) {
    return Message(message: jsonData[kMessage]);
  }
}
